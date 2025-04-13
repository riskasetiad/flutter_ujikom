import 'package:eventway_p5/app/modules/register/views/register_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: HexColor('#c5e6ed'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Lottie.asset(
              'assets/lottie/login.json',
                width: 450,
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 20), // Tambahkan jarak ke bawah
              child: Text(
                'Selamat Datang',
                style: GoogleFonts.lilitaOne(
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 0, 67, 122),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Masukan Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 15,
                bottom: 0,
              ),
              child: TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Masukan Password',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 67, 122),
                borderRadius: BorderRadius.circular(100),
              ),
              child: TextButton(
                onPressed: () {
                  controller.loginNow();
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
