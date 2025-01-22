import 'package:get/get.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import 'app_routes.dart';

abstract class AppPages {
  // 처음에 보여지는 화면
  static const INITIAL = Routes.HOME;

  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => HomeView(), // 임시로 HomeView 사용
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => HomeView(), // 임시로 HomeView 사용
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => HomeView(), // 임시로 HomeView 사용
      binding: HomeBinding(),
    ),
  ];
}
