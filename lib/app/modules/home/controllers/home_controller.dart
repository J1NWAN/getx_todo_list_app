import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app_base/app/core/utils/dialog_utils.dart';
import 'package:getx_app_base/app/core/utils/logger.dart';
import 'package:getx_app_base/app/data/models/todo_model.dart';
import 'package:getx_app_base/app/data/services/master_storage_service.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  final _todos = <TodoModel>[].obs;

  List<TodoModel> get todos => _todos;

  @override
  void onInit() {
    super.onInit();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final userId = MasterStorageService.auth.getCurrentUserId();
    Logger.info('userId: $userId');
    if (userId != null) {
      final savedTodos = MasterStorageService.todo.getTodos(userId);
      if (savedTodos != null) {
        _todos.assignAll(savedTodos);
      }
    }
  }

  Future<void> _saveTodos() async {
    final userId = MasterStorageService.auth.getCurrentUserId();
    if (userId != null) {
      await MasterStorageService.todo.saveTodos(userId, _todos);
    }
  }

  // 일정 추가 Dialog 호출 및 일정 저장
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

  // 일정 삭제
  Future<void> deleteTodo(String id) async {
    final result = await DialogUtils.showConfirm(
      title: '일정 삭제',
      message: '정말 삭제하시겠습니까?',
      cancelText: '취소',
      confirmText: '삭제',
    );

    if (result == true) {
      _todos.removeWhere((todo) => todo.id == id);
      await _saveTodos();

      Get.snackbar(
        '성공',
        '일정이 삭제되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // 일정 수정
  Future<void> updateTodo(String id) async {
    TodoModel todo = _todos.firstWhere((todo) => todo.id == id);

    final result = await DialogUtils.showInput(
      title: '일정 수정',
      message: '수정할 일정을 입력해주세요.',
      hintText: '일정을 입력하세요',
      cancelText: '취소',
      confirmText: '수정',
      keyboardType: TextInputType.name,
      initialValue: todo.title,
    );

    if (result != null && result.isNotEmpty) {
      final index = _todos.indexWhere((todo) => todo.id == id);
      _todos[index] = TodoModel(
        id: id,
        title: result,
        createdAt: todo.createdAt,
      );

      await _saveTodos();

      Get.snackbar(
        '성공',
        '일정이 수정되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // 일정 완료
  Future<void> successTodo(String id) async {
    final index = _todos.indexWhere((todo) => todo.id == id);
    _todos[index] = TodoModel(
      id: _todos[index].id,
      title: _todos[index].title,
      isCompleted: true,
      createdAt: _todos[index].createdAt,
    );
    await _saveTodos();
  }
}
