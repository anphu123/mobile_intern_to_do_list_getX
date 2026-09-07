import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';

/// Thin wrapper around [Get.snackbar] so call sites don't repeat styling.
abstract class AppSnackbar {
  AppSnackbar._();

  static void success(String message) => _show('Success', message, AppColors.success);

  static void error(String message) => _show('Error', message, AppColors.danger);

  static void _show(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      backgroundColor: color,
      colorText: Get.theme.colorScheme.onError,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
