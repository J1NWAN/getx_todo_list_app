import 'package:get/get.dart';
import 'package:getx_app_base/app/modules/home/bindings/home_binding.dart';
import 'package:getx_app_base/app/modules/home/views/home_view.dart';
import 'package:getx_app_base/app/modules/login/bindings/login_binding.dart';
import 'package:getx_app_base/app/modules/login/views/login_views.dart';
import 'app_routes.dart';

abstract class AppPages {
  // 처음에 보여지는 화면
  static const INITIAL = Routes.LOGIN;

  static List<GetPage> routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
