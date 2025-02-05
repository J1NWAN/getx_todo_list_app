import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../buttons/custom_button.dart';

class CustomDatePickerDialog extends StatelessWidget {
  final String title;
  final String? message;
  final DateTime initialDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final String? confirmText;
  final String? cancelText;
  final bool isDismissible;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  final Rx<DateTime> _selectedDate;

  CustomDatePickerDialog({
    super.key,
    required this.title,
    this.message,
    required this.initialDate,
    this.minimumDate,
    this.maximumDate,
    this.confirmText,
    this.cancelText,
    this.isDismissible = true,
    this.onConfirm,
    this.onCancel,
  }) : _selectedDate = initialDate.obs;

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
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initialDate,
              minimumDate: minimumDate,
              maximumDate: maximumDate,
              onDateTimeChanged: (DateTime newDate) {
                _selectedDate.value = newDate;
              },
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
                  Get.back(result: null);
                },
                backgroundColor: Colors.grey[300],
                textColor: Colors.black87,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomButton(
                text: confirmText?.tr ?? '선택'.tr,
                onPressed: () {
                  if (onConfirm != null) onConfirm!();
                  Get.back(result: _selectedDate.value);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
