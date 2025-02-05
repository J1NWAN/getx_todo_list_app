import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app_base/app/core/theme/theme_controller.dart';
import 'package:getx_app_base/app/core/utils/dialog_utils.dart';
import 'package:getx_app_base/app/core/widgets/buttons/custom_dropdown_button.dart';
import 'package:getx_app_base/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('나만의 할 일 목록'),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Get.offAllNamed('/login');
          },
        ),
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                themeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: themeController.toggleTheme,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 검색 바
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '검색어를 입력하세요',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Obx(() => controller.searchText.value.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: controller.clearSearch,
                      )
                    : const SizedBox.shrink()),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => controller.searchText.value = value,
            ),
          ),
          // 카테고리 필터
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // 날짜 필터
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Obx(() => OutlinedButton.icon(
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        controller.selectedDate.value != null
                            ? '${controller.selectedDate.value!.year}-${controller.selectedDate.value!.month}-${controller.selectedDate.value!.day}'
                            : '날짜 선택',
                      ),
                      onPressed: () async {
                        final result = await DialogUtils.showDatePicker(
                          title: '날짜 선택',
                          message: '필터링할 날짜를 선택해주세요',
                          initialDate: controller.selectedDate.value ?? DateTime.now(),
                          minimumDate: DateTime.now().subtract(const Duration(days: 365)),
                          maximumDate: DateTime.now().add(const Duration(days: 365)),
                        );

                        if (result != null) {
                          controller.selectedDate.value = result;
                        }
                      },
                    )),
              ),
              // 날짜 필터 초기화 버튼
              if (controller.selectedDate.value != null)
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: controller.clearDateFilter,
                ),
              // 기존 카테고리 필터
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Obx(
                  () => CustomDropDownButton(
                    label: '카테고리',
                    categories: controller.categories,
                    value: controller.selectedCategoryId.value ?? '0',
                    onChanged: (value) {
                      controller.selectedCategoryId.value = value;
                      if (value == '0') {
                        controller.clearCategoryFilter();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),

          // 할 일 목록
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.filteredTodos.length,
                itemBuilder: (context, index) {
                  final todo = controller.filteredTodos[index];
                  final categoryColor = controller.getCategoryColor(todo.categoryId);
                  return InkWell(
                    onTap: () {
                      controller.updateTodo(todo.id);
                    },
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(
                          todo.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
                        ),
                        onPressed: () {
                          controller.successTodo(todo.id);
                        },
                      ),
                      title: Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Color(int.parse(categoryColor)),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(todo.title),
                        ],
                      ),
                      subtitle: Text(todo.createdAt.toString()),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          controller.deleteTodo(todo.id);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.createTodo();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
