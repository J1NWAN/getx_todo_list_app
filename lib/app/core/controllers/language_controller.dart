import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app_base/app/data/services/storage_service.dart';

class LanguageController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  final _locale = const Locale('ko', 'KR').obs;

  Locale get locale => _locale.value;

  @override
  void onInit() {
    super.onInit();
    _loadLocale();
  }

  void _loadLocale() {
    final savedLocale = _storageService.locale;
    if (savedLocale != null) {
      final parts = savedLocale.split('_');
      if (parts.length == 2) {
        _locale.value = Locale(parts[0], parts[1]);
      }
    }
  }

  void changeLocale(String languageCode, String countryCode) {
    _locale.value = Locale(languageCode, countryCode);
    Get.updateLocale(_locale.value);
    _storageService.saveLocale('${languageCode}_$countryCode');
  }

  void toggleLanguage() {
    if (_locale.value.languageCode == 'ko') {
      changeLocale('en', 'US');
    } else {
      changeLocale('ko', 'KR');
    }
  }
}
