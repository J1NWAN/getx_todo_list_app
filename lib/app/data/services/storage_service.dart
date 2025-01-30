import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:getx_app_base/app/data/models/user_model.dart';
import '../models/todo_model.dart';

class StorageService {
  final _box = GetStorage();
  final _themeKey = 'theme_mode';
  static const LOCALE_KEY = 'locale';
  static const String TODOS_KEY = 'todos';
  static const String USERS_KEY = 'users';

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

  // 유저 조회
  UserModel? getUser(String id, String password) {
    final usersJson = _box.read<String>(USERS_KEY);
    if (usersJson == null) return null;

    final List<dynamic> decoded = json.decode(usersJson);
    for (var user in decoded) {
      if (user['id'] == id && user['password'] == password) {
        return UserModel.fromJson(user);
      }
    }
    return null;
  }

  Future<List<UserModel>> getUsers() async {
    final usersJson = _box.read<String>(USERS_KEY);
    if (usersJson == null) return [];

    final List<dynamic> decoded = json.decode(usersJson);
    return decoded.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<void> saveUser(UserModel user) async {
    final encodedUsers = json.encode([user.toJson()]);
    await _box.write(USERS_KEY, encodedUsers);
  }

  // 유저 찾기
  Future<UserModel?> findUser(String id, String name) async {
    final users = await getUsers();
    for (var user in users) {
      if (user.id == id && user.name == name) {
        return user;
      }
    }
    return null;
  }

  Future<void> updateUserPassword(String id, String newPassword) async {
    final users = await getUsers();
    for (var user in users) {
      if (user.id == id) {
        final updatedUser = UserModel(
          id: user.id,
          password: newPassword,
          name: user.name,
          createdAt: user.createdAt,
        );
        users[users.indexOf(user)] = updatedUser;
        final encodedUsers = json.encode(users.map((u) => u.toJson()).toList());
        await _box.write(USERS_KEY, encodedUsers);
      }
    }
  }
}
