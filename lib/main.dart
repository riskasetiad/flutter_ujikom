import 'package:eventway_p5/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:eventway_p5/app/routes/app_pages.dart'; // Implikasi app_pages.dart sudah cukup
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/modules/dashboard/controllers/kategori_controller.dart';

void main() {
  // Inject controller sebelum app dijalankan
  Get.lazyPut(() => KategoriController());
  Get.lazyPut(() => DashboardController()); // ← tambahkan ini

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Eventway',
      initialRoute: Routes.HOME, // Starting route
      getPages: AppPages.routes, // atau halaman pertamamu
    );
  }
}
