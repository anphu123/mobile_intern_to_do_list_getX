import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'db_helper.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Lỗi',
        'Vui lòng nhập đầy đủ tài khoản và mật khẩu',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;
      final isValid = await DatabaseHelper.instance.checkLogin(username, password);

      if (isValid) {
        Get.snackbar(
          'Thành công',
          'Đăng nhập thành công!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.2),
        );
        // Điều hướng màn hình nếu cần, ví dụ:
        Get.offAllNamed('/home');

      } else {
        Get.snackbar(
          'Thất bại',
          'Sai tài khoản hoặc mật khẩu',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.2),
        );
      }
    } catch (e) {
      Get.snackbar('Lỗi hệ thống', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}