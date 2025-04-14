import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    return Obx(
      () => Scaffold(
        body: Container(
          color: Colors.blue[100], // ✅ Warna latar belakang navigator
          child: Navigator(
            key: Get.nestedKey(1),
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (_) =>
                    controller.pages[controller.selectedIndex.value],
              );
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colors.black, // warna ikon aktif
          unselectedItemColor: Colors.grey[800], // warna ikon tidak aktif
          onTap: (index) {
            controller.changeIndex(index);
            Get.nestedKey(1)!.currentState!.pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => controller.pages[index],
                  ),
                );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Index',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Your Event',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Kategori',
            ),
          ],
        ),
      ),
    );
  }
}
