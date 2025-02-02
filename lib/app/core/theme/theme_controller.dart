import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:getx_app_base/app/data/services/master_storage_service.dart';
import 'app_themes.dart';

class ThemeController extends GetxController {
  final _isDarkMode = false.obs;

  bool get isDarkMode => _isDarkMode.value;
  ThemeMode get themeMode => _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
  ThemeData get theme => _isDarkMode.value ? AppThemes.darkTheme : AppThemes.lightTheme;

  @override
  void onInit() {
    super.onInit();
    _loadThemeMode();
  }

  void _loadThemeMode() {
    _isDarkMode.value = MasterStorageService.settings.isDarkMode;
  }

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(themeMode);
    MasterStorageService.settings.saveThemeMode(_isDarkMode.value);
  }
}
