import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app_base/app/data/models/category_model.dart';
import '../widgets/dialogs/confirm_dialog.dart';
import '../widgets/dialogs/loading_dialog.dart';
import '../widgets/dialogs/input_dialog.dart';
import '../widgets/dialogs/todo_input_dialog.dart';
import '../widgets/dialogs/custom_date_picker_dialog.dart';

class DialogUtils {
  static Future<bool?> showConfirm({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isDismissible = true,
  }) {
    return Get.dialog<bool>(
      ConfirmDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        isDismissible: isDismissible,
      ),
      barrierDismissible: isDismissible,
    );
  }

  static void showLoading({String? message}) {
    Get.dialog(
      LoadingDialog(message: message),
      barrierDismissible: false,
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  static Future<String?> showInput({
    required String title,
    String? message,
    String? hintText,
    String? initialValue,
    String? confirmText,
    String? cancelText,
    bool isDismissible = true,
    TextInputType? keyboardType,
  }) {
    return Get.dialog<String>(
      InputDialog(
        title: title,
        message: message,
        hintText: hintText,
        initialValue: initialValue,
        confirmText: confirmText,
        cancelText: cancelText,
        isDismissible: isDismissible,
        keyboardType: keyboardType,
      ),
      barrierDismissible: isDismissible,
    );
  }

  static Future<Map<String, String>?> showTodoInput({
    required String title,
    required List<CategoryModel> categories,
    String? message,
    String? hintText,
    String? initialValue,
    String? selectedCategoryId,
    String? confirmText,
    String? cancelText,
    bool isDismissible = true,
    TextInputType? keyboardType,
  }) {
    return Get.dialog<Map<String, String>>(
      TodoInputDialog(
        title: title,
        categories: categories,
        message: message,
        hintText: hintText,
        initialValue: initialValue,
        selectedCategoryId: selectedCategoryId,
        confirmText: confirmText,
        cancelText: cancelText,
        isDismissible: isDismissible,
        keyboardType: keyboardType,
      ),
      barrierDismissible: isDismissible,
    );
  }

  static Future<DateTime?> showDatePicker({
    required String title,
    String? message,
    required DateTime initialDate,
    DateTime? minimumDate,
    DateTime? maximumDate,
    String? confirmText,
    String? cancelText,
    bool isDismissible = true,
  }) {
    return Get.dialog<DateTime>(
      CustomDatePickerDialog(
        title: title,
        message: message,
        initialDate: initialDate,
        minimumDate: minimumDate,
        maximumDate: maximumDate,
        confirmText: confirmText,
        cancelText: cancelText,
        isDismissible: isDismissible,
      ),
      barrierDismissible: isDismissible,
    );
  }

  static Future<void> showBottomDatePicker({
    DateTime? initialDate,
    DateTime? minimumDate,
    DateTime? maximumDate,
    Function(DateTime)? onDateTimeChanged,
    String? confirmText,
    String? cancelText,
  }) {
    return Get.bottomSheet(
      CustomDatePicker(
        initialDate: initialDate,
        minimumDate: minimumDate,
        maximumDate: maximumDate,
        onDateTimeChanged: onDateTimeChanged,
        confirmText: confirmText,
        cancelText: cancelText,
      ),
      isScrollControlled: true,
      enableDrag: true,
    );
  }
}
