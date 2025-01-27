import 'package:get/get.dart';
import 'package:getx_app_base/app/core/controllers/language_controller.dart';
import 'package:getx_app_base/app/modules/login/controllers/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<LanguageController>(
      () => LanguageController(),
    );
  }
}
