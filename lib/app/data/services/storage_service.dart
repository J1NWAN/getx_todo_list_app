import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../models/todo_model.dart';

class StorageService {
  final _box = GetStorage();
  final _themeKey = 'theme_mode';
  static const LOCALE_KEY = 'locale';
  static const String TODOS_KEY = 'todos';

  bool get isDarkMode => _box.read(_themeKey) ?? false;

  Future<void> saveThemeMode(bool isDarkMode) async {
    await _box.write(_themeKey, isDarkMode);
  }

  String? get locale => _box.read(LOCALE_KEY);

  Future<void> saveLocale(String locale) async {
    await _box.write(LOCALE_KEY, locale);
  }

  List<TodoModel>? getTodos() {
    final todosJson = _box.read<String>(TODOS_KEY);
    if (todosJson == null) return null;

    final List<dynamic> decoded = json.decode(todosJson);
    return decoded.map((json) => TodoModel.fromJson(json)).toList();
  }

  Future<void> saveTodos(List<TodoModel> todos) async {
    final encodedTodos = json.encode(
      todos.map((todo) => todo.toJson()).toList(),
    );
    await _box.write(TODOS_KEY, encodedTodos);
  }
}
