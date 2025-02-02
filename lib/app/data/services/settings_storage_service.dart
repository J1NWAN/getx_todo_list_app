import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get_storage/get_storage.dart';

class SettingsStorageService extends GetxService {
  static const String THEME_KEY = 'theme_mode';
  static const String LOCALE_KEY = 'locale';
  final _box = GetStorage();

  bool get isDarkMode => _box.read(THEME_KEY) ?? false;

  Future<void> saveThemeMode(bool isDarkMode) async {
    await _box.write(THEME_KEY, isDarkMode);
  }

  String? get locale => _box.read(LOCALE_KEY);

  Future<void> saveLocale(String locale) async {
    await _box.write(LOCALE_KEY, locale);
  }
}
