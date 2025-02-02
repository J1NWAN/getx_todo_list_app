import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app_base/app/data/models/category_model.dart';
import '../buttons/custom_button.dart';

class TodoInputDialog extends StatelessWidget {
  final String title;
  final String? message;
  final String? hintText;
  final String? initialValue;
  final List<CategoryModel> categories;
  final String? selectedCategoryId;
  final String? confirmText;
  final String? cancelText;
  final bool isDismissible;
  final TextInputType? keyboardType;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  final TextEditingController _textController = TextEditingController();
  final RxString _selectedCategory = ''.obs;

  TodoInputDialog({
    super.key,
    required this.title,
    required this.categories,
    this.message,
    this.hintText,
    this.initialValue,
    this.selectedCategoryId,
    this.confirmText,
    this.cancelText,
    this.isDismissible = true,
    this.keyboardType,
    this.onConfirm,
    this.onCancel,
  }) {
    _textController.text = initialValue ?? '';
    _selectedCategory.value = selectedCategoryId ?? categories.first.id;
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
          const SizedBox(height: 16),
          Obx(
            () => DropdownButtonFormField<String>(
              value: _selectedCategory.value,
              decoration: const InputDecoration(
                labelText: '카테고리',
                border: OutlineInputBorder(),
              ),
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category.id,
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Color(int.parse(category.color)),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(category.name),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  _selectedCategory.value = value;
                }
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
                text: confirmText?.tr ?? '저장'.tr,
                onPressed: () {
                  if (onConfirm != null) onConfirm!();
                  Get.back(result: {
                    'title': _textController.text,
                    'categoryId': _selectedCategory.value,
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
