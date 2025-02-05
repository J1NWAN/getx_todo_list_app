import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app_base/app/core/theme/theme_controller.dart';
import 'package:getx_app_base/app/core/utils/device_utils.dart';
import 'package:getx_app_base/app/core/utils/logger.dart';
import 'package:getx_app_base/app/core/theme/app_themes.dart';
import 'package:getx_app_base/app/routes/app_pages.dart';
import 'package:getx_app_base/app/core/translations/app_translations.dart';
import 'package:getx_app_base/app/core/controllers/language_controller.dart';
import 'package:getx_app_base/app/data/services/master_storage_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 모든 스토리지 서비스 초기화
  await MasterStorageService.init();

  // 컨트롤러 초기화
  Get.put(ThemeController());
  Get.put(LanguageController());

  Logger.info('DeviceId: ${await DeviceUtils.getDeviceId()}');
  Logger.info('DeviceName: ${await DeviceUtils.getDeviceName()}');
  Logger.info('AppVersion: ${await DeviceUtils.getAppVersion()}');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final languageController = Get.find<LanguageController>();

    return GetMaterialApp(
      title: 'GetX Todo',
      initialRoute: AppPages.INITIAL,
      getPages: [...AppPages.routes],
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeController.themeMode,
      translations: AppTranslations(),
      locale: languageController.locale,
      fallbackLocale: const Locale('ko', 'KR'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', 'US'),
      ],
    );
  }
}
