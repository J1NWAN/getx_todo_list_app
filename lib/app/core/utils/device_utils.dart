import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:getx_app_base/app/core/utils/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtils {
  static bool get isIOS => GetPlatform.isIOS;
  static bool get isAndroid => GetPlatform.isAndroid;

  static Future<String> getDeviceId() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id;
      } else if (isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? '';
      }
      return '';
    } catch (e) {
      Logger.error('getDeviceId 오류', e);
      return '';
    }
  }

  static Future<String> getAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.version;
    } catch (e) {
      Logger.error('getAppVersion 오류', e);
      return '';
    }
  }

  static Future<String> getDeviceName() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return androidInfo.model;
      } else if (isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return iosInfo.name;
      }
      return '';
    } catch (e) {
      Logger.error('getDeviceName 오류', e);
      return '';
    }
  }
}
