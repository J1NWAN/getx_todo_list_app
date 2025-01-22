import 'package:flutter/foundation.dart';

class Logger {
  static void debug(String message) {
    if (kDebugMode) print('🐛 DEBUG: $message');
  }

  static void error(String message, [dynamic error]) {
    if (kDebugMode) print('❌ ERROR: $message\n${error ?? ""}');
  }

  static void info(String message) {
    if (kDebugMode) print('ℹ️ INFO: $message');
  }
}
