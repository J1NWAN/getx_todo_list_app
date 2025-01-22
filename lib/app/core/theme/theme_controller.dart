import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../data/services/storage_service.dart';
import 'app_themes.dart';

class ThemeController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
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
    _isDarkMode.value = _storageService.isDarkMode;
  }

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(themeMode);
    _storageService.saveThemeMode(_isDarkMode.value);
  }
}
