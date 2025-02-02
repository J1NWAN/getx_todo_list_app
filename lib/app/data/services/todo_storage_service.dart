import 'dart:convert';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_app_base/app/data/models/todo_model.dart';

class TodoStorageService extends GetxService {
  static const String TODOS_KEY = 'todos';
  final _box = GetStorage();

  List<TodoModel>? getTodos(String userId) {
    final todosJson = _box.read<String>('${TODOS_KEY}_$userId');
    if (todosJson == null) return null;

    final List<dynamic> decoded = json.decode(todosJson);
    return decoded.map((json) => TodoModel.fromJson(json)).toList();
  }

  Future<void> saveTodos(String userId, List<TodoModel> todos) async {
    final encodedTodos = json.encode(
      todos.map((todo) => todo.toJson()).toList(),
    );
    await _box.write('${TODOS_KEY}_$userId', encodedTodos);
  }
}
