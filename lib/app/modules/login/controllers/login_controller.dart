import 'package:eventway_p5/app/modules/dashboard/views/dashboard_view.dart';
import 'package:eventway_p5/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final _getConnect = GetConnect();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authToken = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  @override
  void loginNow() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Oops!',
        'Email dan password wajib diisi.',
        icon: const Icon(Icons.info_outline, color: Colors.white),
        backgroundColor: Colors.orange.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
      );
      return;
    }

    final response = await _getConnect.post(BaseUrl.login, {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      authToken.write('access_token', response.body['access_token']);
      Get.offAll(() => const DashboardView());
    } else {
      String errorMsg = 'Terjadi kesalahan. Silakan coba lagi.';
      if (response.body != null && response.body['error'] != null) {
        final error = response.body['error'].toString().toLowerCase();
        if (error.contains('email')) {
          errorMsg = 'Email tidak terdaftar.';
        } else if (error.contains('password')) {
          errorMsg = 'Password yang dimasukkan salah.';
        } else {
          errorMsg = response.body['error'].toString();
        }
      }

      Get.snackbar(
        'Login Gagal',
        errorMsg,
        icon: const Icon(Icons.error_outline, color: Colors.white),
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
      );
    }
  }
}
