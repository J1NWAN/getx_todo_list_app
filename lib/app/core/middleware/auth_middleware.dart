import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    // 인증 로직 구현
    // 예: 로그인이 필요한 페이지 접근 시 로그인 페이지로 리다이렉트
    return null;
  }
}
