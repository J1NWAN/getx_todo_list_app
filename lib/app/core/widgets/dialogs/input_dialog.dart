import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_app_base/app/core/widgets/buttons/custom_button.dart';

class InputDialog extends StatelessWidget {
  final String title;
  final String? message;
  final String? hintText;
  final String? initialValue;
  final String? confirmText;
  final String? cancelText;
  final bool isDismissible;
  final TextInputType? keyboardType;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  final TextEditingController _textController = TextEditingController();

  InputDialog({
    super.key,
    required this.title,
    this.message,
    this.hintText,
    this.initialValue,
    this.confirmText,
    this.cancelText,
    this.isDismissible = true,
    this.keyboardType,
    this.onConfirm,
    this.onCancel,
  }) {
    _textController.text = initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(message!),
            ),
          TextField(
            controller: _textController,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: CustomButton(
                text: cancelText?.tr ?? '취소'.tr,
                onPressed: () {
                  if (onCancel != null) onCancel!();
                  Get.back(result1: null);
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
                  Get.back(result: _textController.text);
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
