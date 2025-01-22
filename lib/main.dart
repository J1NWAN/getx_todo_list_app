import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:getx_app_base/app/core/theme/theme_controller.dart';
import 'package:getx_app_base/app/core/utils/device_utils.dart';
import 'package:getx_app_base/app/core/utils/logger.dart';
import 'package:getx_app_base/app/data/services/storage_service.dart';
import 'package:getx_app_base/app/core/theme/app_themes.dart';
import 'package:getx_app_base/app/routes/app_pages.dart';
import 'package:getx_app_base/app/core/translations/app_translations.dart';
import 'package:getx_app_base/app/core/controllers/language_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(StorageService());
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
    );
  }
}
