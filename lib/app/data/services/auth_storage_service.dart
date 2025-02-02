import 'dart:convert';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_app_base/app/data/models/user_model.dart';

class AuthStorageService extends GetxService {
  static const String USERS_KEY = 'users';
  static const String CURRENT_USER_KEY = 'current_user';
  final _box = GetStorage();

  // 현재 로그인한 사용자 ID 저장
  Future<void> saveCurrentUserId(String userId) async {
    await _box.write(CURRENT_USER_KEY, userId);
  }

  String? getCurrentUserId() {
    final usersJson = _box.read<String>(USERS_KEY);
    if (usersJson == null) return null;

    final List<dynamic> decoded = json.decode(usersJson);
    return decoded[0]['id'];
  }

  Future<void> clearCurrentUser() async {
    await _box.remove(CURRENT_USER_KEY);
  }

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
