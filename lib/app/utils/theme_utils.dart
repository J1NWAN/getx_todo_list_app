import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeUtils {
  static bool get isDarkMode => Get.isDarkMode;

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  static TextStyle? getHeadline1Style(BuildContext context) {
    return Theme.of(context).textTheme.displayLarge;
  }

  // ... 더 많은 유틸리티 메서드
}
