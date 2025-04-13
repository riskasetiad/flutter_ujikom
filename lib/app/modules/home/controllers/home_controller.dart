import 'dart:async';

import 'package:eventway_p5/app/modules/dashboard/views/dashboard_view.dart';
import 'package:eventway_p5/app/modules/login/views/login_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

 late Timer _pindah;
  final authToken = GetStorage();

  @override
  void onInit() {
    _pindah = Timer.periodic(
      const Duration(seconds: 4),
      (timer) => authToken.read('token') == null
          ? Get.off(
              () => const LoginView(),
              transition: Transition.leftToRight,
            )
          : Get.off(() => const DashboardView()),
    );
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _pindah.cancel();
    super.onClose();
  }
}
