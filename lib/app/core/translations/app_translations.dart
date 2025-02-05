import 'package:get/get.dart';
import 'languages/en_us.dart';
import 'languages/ko_kr.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': koKR,
        'en_US': enUS,
      };

  static final Map<String, Map<String, String>> translations = {
    'en_US': {
      'date_picker_title': 'Select Date',
      'date_picker_message': 'Please select a date',
      'date_picker_cancel': 'Cancel',
      'date_picker_confirm': 'Select',
    },
    'ko_KR': {
      'date_picker_title': '날짜 선택',
      'date_picker_message': '날짜를 선택해주세요',
      'date_picker_cancel': '취소',
      'date_picker_confirm': '선택',
    },
  };
}
