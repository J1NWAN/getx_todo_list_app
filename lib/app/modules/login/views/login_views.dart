import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app_base/app/core/widgets/buttons/custom_button.dart';
import 'package:getx_app_base/app/core/widgets/inputs/custom_text_field.dart';
import 'package:getx_app_base/app/modules/login/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: CustomTextField(
                  controller: controller.idController,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '아이디를 입력해주세요.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => SizedBox(
                  width: 300,
                  child: CustomTextField(
                    obscureText: !controller.isPasswordVisible.value,
                    suffix: GestureDetector(
                      onTap: () {
                        controller.isPasswordVisible.value = !controller.isPasswordVisible.value;
                      },
                      child: Icon(
                        controller.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    controller: controller.passwordController,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '비밀번호를 입력해주세요.';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('아이디 찾기'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('비밀번호 찾기'),
                  ),
                ],
              ),
              CustomButton(
                isFullWidth: false,
                width: 300,
                height: 50,
                text: '로그인',
                onPressed: () {
                  if (controller.idController.text.isEmpty || controller.passwordController.text.isEmpty) {
                    Get.snackbar('알림', '아이디와 비밀번호를 입력해주세요.');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
