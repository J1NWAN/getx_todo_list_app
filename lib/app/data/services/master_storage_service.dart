import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'auth_storage_service.dart';
import 'todo_storage_service.dart';
import 'settings_storage_service.dart';

class MasterStorageService extends GetxService {
  static Future<void> init() async {
    await GetStorage.init();

    // 스토리지 서비스들 초기화
    Get.put(AuthStorageService());
    Get.put(TodoStorageService());
    Get.put(SettingsStorageService());
  }

  // 편의를 위한 getter 메서드들
  static AuthStorageService get auth => Get.find<AuthStorageService>();
  static TodoStorageService get todo => Get.find<TodoStorageService>();
  static SettingsStorageService get settings => Get.find<SettingsStorageService>();
}
