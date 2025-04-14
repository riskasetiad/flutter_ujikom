import 'package:eventway_p5/app/data/event_response.dart';
import 'package:eventway_p5/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:eventway_p5/app/modules/dashboard/views/event_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class YourEventView extends GetView {
  const YourEventView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Events'),
        centerTitle: true,
        backgroundColor: Colors.blue[100], // Added color to appBar
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.blue[100], // Set the background color to blue[100]
        child: FutureBuilder<EventResponse>(
          future: controller.getEvent(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child:
                    CircularProgressIndicator(), // Replaced Lottie with CircularProgressIndicator
              );
            }
            if (!snapshot.hasData || snapshot.data!.events!.isEmpty) {
              return const Center(child: Text("Tidak ada event"));
            }

            return ListView.builder(
              itemCount: snapshot.data!.events!.length,
              itemBuilder: (context, index) {
                final event = snapshot.data!.events![index];
                return eventList(event);
              },
            );
          },
        ),
      ),
    );
  }

  ZoomTapAnimation eventList(Events event) {
    return ZoomTapAnimation(
      onTap: () {
        Get.to(() => EventDetailView(event: event));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title ?? 'Judul Tidak Tersedia',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tanggal: ${event.tglMulai ?? 'Belum ditentukan'}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    event.lokasi ?? 'Lokasi Tidak Tersedia',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
          ],
        ),
      ),
    );
  }
}
