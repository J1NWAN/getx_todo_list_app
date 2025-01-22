import 'package:get/get.dart';
import 'package:getx_app_base/app/modules/home/controllers/home_controller.dart';
import 'package:getx_app_base/app/core/controllers/language_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<LanguageController>(
      () => LanguageController(),
    );
  }
}
