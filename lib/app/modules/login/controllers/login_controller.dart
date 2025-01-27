import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app_base/app/data/models/todo_model.dart';
import 'package:getx_app_base/app/data/services/storage_service.dart';

class LoginController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final isPasswordVisible = false.obs;
}
