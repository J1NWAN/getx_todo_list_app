import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.headline1,
      displayMedium: AppTextStyles.headline2,
      // ... 더 많은 텍스트 스타일
    ),
    // 기타 테마 속성들
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: TextTheme(
      displayLarge: AppTextStyles.headline1.copyWith(color: Colors.white),
      displayMedium: AppTextStyles.headline2.copyWith(color: Colors.white),
      // ... 더 많은 텍스트 스타일
    ),
    // 기타 테마 속성들
  );
}
