# getx_app_base

GetX를 사용한 앱 기본 틀 작성

## 프로젝트 구조

- app/
  - core/
    - controllers/
      - language_controller.dart
    - theme/
      - theme_controller.dart
      - app_themes.dart
    - widgets/
      - buttons/
        - custom_button.dart
      - inputs/
        - custom_text_field.dart
      - common/
        - loading_indicator.dart
      - dialogs/
        - confirm_dialog.dart
        - loading_dialog.dart
    - translations/
      - app_translations.dart
      - languages/
        - en_us.dart
        - ko_kr.dart
    - utils/
      - device_utils.dart
      - dialog_utils.dart
      - logger.dart
  - data/
    - services/
      - storage_service.dart
  - modules/
    - home/
      - controllers/
        - home_controller.dart
      - views/
        - home_view.dart
      - bindings/
        - home_binding.dart
  - routes/
    - app_pages.dart
    - app_routes.dart
