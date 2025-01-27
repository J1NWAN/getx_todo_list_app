import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../buttons/custom_button.dart';

class InputField {
  final String label;
  final String? hintText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool isRequired;

  InputField({
    required this.label,
    this.hintText,
    this.initialValue,
    this.keyboardType,
    this.isRequired = false,
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
                child: TextField(
                  controller: _controllers[index],
                  keyboardType: fields[index].keyboardType,
                  decoration: InputDecoration(
                    labelText: fields[index].label,
                    hintText: fields[index].hintText,
                    border: const OutlineInputBorder(),
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
                  if (onConfirm != null) onConfirm!();
                  Get.back(
                    result: _controllers.map((c) => c.text).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
