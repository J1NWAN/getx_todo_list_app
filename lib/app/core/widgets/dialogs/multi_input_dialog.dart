import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../buttons/custom_button.dart';

class InputField {
  final String label;
  final String? hintText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool isRequired;
  final bool obscureText;
  final bool showPasswordToggle;

  InputField({
    required this.label,
    this.hintText,
    this.initialValue,
    this.keyboardType,
    this.isRequired = false,
    this.obscureText = false,
    this.showPasswordToggle = false,
  });
}

class MultiInputDialog extends StatelessWidget {
  final String title;
  final String? message;
  final List<InputField> fields;
  final String? confirmText;
  final String? cancelText;
  final bool isDismissible;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  final List<TextEditingController> _controllers = [];
  final List<RxBool> _obscureTextList = [];

  MultiInputDialog({
    super.key,
    required this.title,
    this.message,
    required this.fields,
    this.confirmText,
    this.cancelText,
    this.isDismissible = true,
    this.onConfirm,
    this.onCancel,
  }) {
    for (var field in fields) {
      _controllers.add(TextEditingController(text: field.initialValue ?? ''));
      _obscureTextList.add(field.obscureText.obs);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(message!),
              ),
            ...List.generate(
              fields.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Obx(
                  () => TextField(
                    controller: _controllers[index],
                    keyboardType: fields[index].keyboardType,
                    obscureText: _obscureTextList[index].value,
                    decoration: InputDecoration(
                      labelText: fields[index].label,
                      hintText: fields[index].hintText,
                      border: const OutlineInputBorder(),
                      suffixIcon: fields[index].showPasswordToggle
                          ? IconButton(
                              icon: Icon(
                                _obscureTextList[index].value ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                _obscureTextList[index].value = !_obscureTextList[index].value;
                              },
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: CustomButton(
                text: cancelText?.tr ?? '취소'.tr,
                onPressed: () {
                  if (onCancel != null) onCancel!();
                  Get.back(result: null);
                },
                backgroundColor: Colors.grey[300],
                textColor: Colors.black87,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomButton(
                text: confirmText?.tr ?? '저장'.tr,
                onPressed: () {
                  final values = _controllers.map((c) => c.text).toList();

                  if (fields.every((field) => field.isRequired)) {
                    // 필수 입력 필드 검사
                    for (int i = 0; i < fields.length; i++) {
                      if (fields[i].isRequired && values[i].isEmpty) {
                        Get.snackbar(
                          '알림',
                          '${fields[i].label}을(를) 입력해주세요.',
                          snackPosition: SnackPosition.TOP,
                        );
                        return; // 다이얼로그 유지
                      }
                    }
                  }

                  // 모든 검증을 통과하면 다이얼로그 닫기
                  if (onConfirm != null) onConfirm!();
                  Get.back(result: values);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
