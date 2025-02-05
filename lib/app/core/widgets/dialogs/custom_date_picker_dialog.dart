import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  String get formattedDate {
    final locale = Get.locale?.languageCode ?? 'en';
    final format = locale == 'ko' ? DateFormat('yyyy년 MM월 dd일') : DateFormat('MMM dd, yyyy');
    return format.format(_selectedDate.value);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(message!.tr),
            ),
          // 선택된 날짜 표시
          Obx(() => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
          SizedBox(
            height: 200,
            child: Localizations(
              locale: Get.locale ?? const Locale('en', 'US'),
              delegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: initialDate,
                minimumDate: minimumDate,
                maximumDate: maximumDate,
                onDateTimeChanged: (DateTime newDate) {
                  _selectedDate.value = newDate;
                },
                use24hFormat: true,
              ),
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

class CustomDatePicker extends StatelessWidget {
  final DateTime? initialDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final Function(DateTime)? onDateTimeChanged;
  final String? confirmText;
  final String? cancelText;

  const CustomDatePicker({
    super.key,
    this.initialDate,
    this.minimumDate,
    this.maximumDate,
    this.onDateTimeChanged,
    this.confirmText,
    this.cancelText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initialDate ?? DateTime.now(),
              minimumDate: minimumDate,
              maximumDate: maximumDate,
              onDateTimeChanged: (DateTime newDate) {
                if (onDateTimeChanged != null) {
                  onDateTimeChanged!(newDate);
                }
              },
              use24hFormat: true,
            ),
          ),
        ],
      ),
    );
  }
}
