import 'package:eventway_p5/app/modules/dashboard/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.profile.value;

        return data.id == null
            ? const Center(child: Text('Data tidak tersedia'))
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      data.image != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(data.image!),
                            )
                          : const CircleAvatar(
                              radius: 50,
                              child: Icon(Icons.person),
                            ),
                      const SizedBox(height: 16),
                      Text(
                        data.name ?? '-',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data.email ?? '-',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.logout(), 
        child: const Icon(Icons.logout),
        backgroundColor: Color.fromARGB(255, 194, 232, 254),
        tooltip: 'Keluar',
      ),
    );
  }
}
