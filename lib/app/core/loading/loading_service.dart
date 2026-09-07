import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Global full-screen loading indicator, independent of any one controller.
///
/// Registered as a permanent [GetxService] in [main] (`Get.put(LoadingService(), permanent: true)`)
/// so any controller can call `Get.find<LoadingService>()` to show/hide it
/// around a long-running action instead of building its own dialog.
class LoadingService extends GetxService {
  final isLoading = false.obs;

  void show() {
    if (isLoading.value) return;
    isLoading.value = true;
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
  }

  void hide() {
    if (!isLoading.value) return;
    isLoading.value = false;
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
