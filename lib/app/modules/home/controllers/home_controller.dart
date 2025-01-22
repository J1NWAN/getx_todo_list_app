import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app_base/app/core/utils/dialog_utils.dart';
import 'package:getx_app_base/app/data/models/todo_model.dart';
import 'package:getx_app_base/app/data/services/storage_service.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final _todos = <TodoModel>[].obs;

  List<TodoModel> get todos => _todos;

  Future<void> createTodo() async {
    final result = await DialogUtils.showInput(
      title: '일정 추가',
      message: '추가할 일정을 입력해주세요.',
      hintText: '일정을 입력하세요',
      cancelText: '취소',
      confirmText: '추가',
      keyboardType: TextInputType.name,
    );

    if (result != null && result.isNotEmpty) {
      final todo = TodoModel(
        id: const Uuid().v4(),
        title: result,
        createdAt: DateTime.now(),
      );

      _todos.add(todo);
      await _saveTodos();

      Get.snackbar(
        '성공',
        '새로운 일정이 추가되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _saveTodos() async {
    await _storageService.saveTodos(_todos);
  }
}
