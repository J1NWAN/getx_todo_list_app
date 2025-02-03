import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app_base/app/core/utils/dialog_utils.dart';
import 'package:getx_app_base/app/core/utils/logger.dart';
import 'package:getx_app_base/app/data/models/category_model.dart';
import 'package:getx_app_base/app/data/models/todo_model.dart';
import 'package:getx_app_base/app/data/services/master_storage_service.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  final _todos = <TodoModel>[].obs;
  final RxString searchText = ''.obs;
  final RxnString selectedCategoryId = RxnString();

  List<TodoModel> get todos => _todos;

  // 필터링된 할 일 목록
  List<TodoModel> get filteredTodos {
    return _todos.where((todo) {
      // 검색어 필터
      final matchesSearch = todo.title.toLowerCase().contains(searchText.value.toLowerCase());

      // 카테고리 필터 ('0'은 전체 카테고리)
      final matchesCategory = selectedCategoryId.value == '0' || todo.categoryId == selectedCategoryId.value;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    selectedCategoryId.value = '0'; // 초기값을 '전체' 카테고리로 설정
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
    final result = await DialogUtils.showTodoInput(
      title: '일정 추가',
      message: '추가할 일정을 입력해주세요.',
      hintText: '일정을 입력하세요',
      categories: [
        CategoryModel(id: '1', name: '업무', color: '0xFFFF0000'),
        CategoryModel(id: '2', name: '개인', color: '0xFF00FF00'),
        CategoryModel(id: '3', name: '가족', color: '0xFF0000FF'),
      ],
      cancelText: '취소',
      confirmText: '추가',
      keyboardType: TextInputType.name,
    );

    if (result != null) {
      final todo = TodoModel(
        id: const Uuid().v4(),
        title: result['title']!,
        categoryId: result['categoryId']!,
        createdAt: DateTime.now(),
      );

      _todos.add(todo);
      await _saveTodos();
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

    final result = await DialogUtils.showTodoInput(
      title: '일정 수정',
      message: '수정할 일정을 입력해주세요.',
      hintText: '일정을 입력하세요',
      cancelText: '취소',
      confirmText: '수정',
      keyboardType: TextInputType.name,
      initialValue: todo.title,
      selectedCategoryId: todo.categoryId,
      categories: [
        CategoryModel(id: '1', name: '업무', color: '0xFFFF0000'),
        CategoryModel(id: '2', name: '개인', color: '0xFF00FF00'),
        CategoryModel(id: '3', name: '가족', color: '0xFF0000FF'),
      ],
    );

    if (result != null && result.isNotEmpty) {
      final index = _todos.indexWhere((todo) => todo.id == id);
      _todos[index] = TodoModel(
        id: id,
        title: result['title']!,
        categoryId: result['categoryId']!,
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
      categoryId: _todos[index].categoryId,
      isCompleted: true,
      createdAt: _todos[index].createdAt,
    );
    await _saveTodos();
  }

  String getCategoryColor(String? categoryId) {
    if (categoryId == null) return '0xFF808080'; // 기본 회색

    final category = categories.firstWhereOrNull(
      (category) => category.id == categoryId,
    );

    return category?.color ?? '0xFF808080'; // 카테고리가 없으면 기본 회색 반환
  }

  // 카테고리 목록 (임시 데이터)
  final categories = [
    CategoryModel(
      id: '0', // 전체 카테고리를 위한 ID
      name: '전체',
      color: '0xFF808080',
    ),
    CategoryModel(
      id: '1',
      name: '업무',
      color: '0xFFFF0000',
    ),
    CategoryModel(
      id: '2',
      name: '개인',
      color: '0xFF00FF00',
    ),
    CategoryModel(
      id: '3',
      name: '가족',
      color: '0xFF0000FF',
    ),
  ];

  // 카테고리 필터 초기화
  void clearCategoryFilter() {
    selectedCategoryId.value = '0'; // '전체' 카테고리로 설정
  }

  // 검색어 초기화
  void clearSearch() {
    searchText.value = '';
  }
}
