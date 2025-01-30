import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app_base/app/core/utils/logger.dart';
import 'package:getx_app_base/app/core/widgets/dialogs/multi_input_dialog.dart';
import 'package:getx_app_base/app/data/models/user_model.dart';
import 'package:getx_app_base/app/data/services/storage_service.dart';

class LoginController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final isPasswordVisible = false.obs;

  Future<void> login() async {
    final id = idController.text;
    final password = passwordController.text;

    final user = _storageService.getUser(id, password);
    if (user == null) {
      Get.snackbar('알림', '아이디 또는 비밀번호가 일치하지 않습니다.');
      return;
    }

    Get.offAllNamed('/home');
  }

  Future<void> register() async {
    final id = idController.text;
    final password = passwordController.text;
    final name = nameController.text;

    final users = await _storageService.getUsers();
    if (users.any((user) => user.id == id)) {
      Get.snackbar('알림', '이미 존재하는 아이디입니다.');
      return;
    }

    final user = await _storageService.saveUser(
      UserModel(
        id: id,
        password: password,
        name: name,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> signupDialog() async {
    final result = await Get.dialog<List<String>>(
      MultiInputDialog(
        title: '회원가입',
        message: '아래 정보를 입력해주세요.',
        fields: [
          InputField(
            label: '아이디',
            hintText: '아이디를 입력하세요',
            keyboardType: TextInputType.text,
            isRequired: true,
          ),
          InputField(
            label: '비밀번호',
            hintText: '비밀번호를 입력하세요',
            keyboardType: TextInputType.visiblePassword,
            isRequired: true,
            obscureText: true,
            showPasswordToggle: true,
          ),
          InputField(
            label: '이름',
            hintText: '이름을 입력하세요',
            keyboardType: TextInputType.name,
            isRequired: true,
          ),
        ],
        confirmText: '저장',
        cancelText: '취소',
      ),
    );

    if (result != null) {
      final id = result[0];
      final password = result[1];
      final name = result[2];

      if (id.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
        final users = await _storageService.getUsers();
        if (users.any((user) => user.id == id)) {
          Get.snackbar('알림', '이미 존재하는 아이디입니다.');
          return;
        }

        final user = UserModel(
          id: id,
          password: password,
          name: name,
          createdAt: DateTime.now(),
        );

        await _storageService.saveUser(user);

        Get.snackbar('알림', '회원가입이 완료되었습니다.');
      }
    }
  }

  Future<void> findPasswordDialog() async {
    final result = await Get.dialog<List<String>>(
      MultiInputDialog(
        title: '비밀번호 찾기',
        message: '아이디와 이름을 입력해주세요.',
        fields: [
          InputField(
            label: '아이디',
            hintText: '아이디를 입력하세요',
            keyboardType: TextInputType.text,
            isRequired: true,
          ),
          InputField(
            label: '이름',
            hintText: '이름을 입력하세요',
            keyboardType: TextInputType.name,
            isRequired: true,
          ),
        ],
        confirmText: '확인',
        cancelText: '취소',
      ),
    );

    if (result != null) {
      final id = result[0];
      final name = result[1];

      final user = await _storageService.findUser(id, name);
      Logger.info('user: $user');
      if (user == null) {
        Get.snackbar('알림', '아이디 또는 이름이 일치하지 않습니다.');
        return;
      } else {
        final newPassword = await Get.dialog<List<String>>(
          MultiInputDialog(
            title: '비밀번호 찾기',
            message: '변경할 비밀번호를 입력해주세요.',
            fields: [
              InputField(
                label: '비밀번호',
                hintText: '비밀번호를 입력하세요',
                keyboardType: TextInputType.visiblePassword,
                isRequired: true,
                obscureText: true,
                showPasswordToggle: true,
              ),
            ],
            confirmText: '저장',
            cancelText: '취소',
          ),
        );

        if (newPassword != null) {
          final password = newPassword[0];
          await _storageService.updateUserPassword(user.id, password);
          Get.snackbar('알림', '비밀번호가 변경되었습니다.');
        }
      }
    }
  }
}
