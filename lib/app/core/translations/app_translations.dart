import 'package:get/get.dart';
import 'languages/en_us.dart';
import 'languages/ko_kr.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': koKR,
        'en_US': enUS,
      };
}
