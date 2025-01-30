import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app_base/app/core/theme/theme_controller.dart';
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
      body: Obx(
        () => ListView.builder(
          itemCount: controller.todos.length,
          itemBuilder: (context, index) {
            final todo = controller.todos[index];
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
                title: Text(todo.title),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.createTodo();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
