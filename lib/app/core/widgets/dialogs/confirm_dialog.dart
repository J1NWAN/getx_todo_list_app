import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../buttons/custom_button.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isDismissible;

  /*
   * 확인 다이얼로그 위젯
   * 
   * @param title 제목
   * @param message 메시지
   * @param confirmText 확인 텍스트
   * @param cancelText 취소 텍스트
   * @param onConfirm 확인 클릭 이벤트
   * @param onCancel 취소 클릭 이벤트
   * @param isDismissible 다이얼로그 닫기 가능 여부
   */
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.isDismissible = true,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isDismissible,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title.tr,
                style: Get.textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                message.tr,
                style: Get.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: cancelText?.tr ?? '취소'.tr,
                      onPressed: () {
                        if (onCancel != null) onCancel!();
                        Get.back(result: false);
                      },
                      backgroundColor: Colors.grey[300],
                      textColor: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CustomButton(
                      text: confirmText?.tr ?? '확인'.tr,
                      onPressed: () {
                        if (onConfirm != null) {
                          onConfirm!();
                        }
                        Get.back(result: true);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
