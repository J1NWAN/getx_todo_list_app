import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:getx_app_base/app/data/models/category_model.dart';

class CustomDropDownButton extends StatelessWidget {
  final String label;
  final List<CategoryModel> categories;
  final String value;
  final Function(String) onChanged;

  const CustomDropDownButton({
    super.key,
    required this.label,
    required this.categories,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<String>(
      isExpanded: true,
      underline: const SizedBox(), // 밑줄 제거
      hint: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).hintColor,
        ),
      ),
      items: categories
          .map(
            (CategoryModel category) => DropdownMenuItem<String>(
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
                  Text(
                    category.name,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      value: value,
      onChanged: (String? value) {
        if (value != null) {
          onChanged(value);
        }
      },
      buttonStyleData: ButtonStyleData(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
      ),
    );
  }
}
