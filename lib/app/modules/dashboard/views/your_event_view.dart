import 'package:eventway_p5/app/data/event_response.dart';
import 'package:eventway_p5/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:eventway_p5/app/modules/dashboard/views/event_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<EventResponse>(
          future: controller.getEvent(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.network(
                  'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                  repeat: true,
                  width: MediaQuery.of(context).size.width / 1,
                ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
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
    );
  }
}
