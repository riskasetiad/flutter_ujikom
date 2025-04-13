import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eventway_p5/app/data/event_response.dart';
import 'package:eventway_p5/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:eventway_p5/app/modules/dashboard/views/event_detail_view.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class IndexView extends GetView<DashboardController> {
  const IndexView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<EventResponse>(
          future: controller.eventFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData ||
                snapshot.data?.events == null ||
                snapshot.data!.events!.isEmpty) {
              return const Center(child: Text("Tidak ada event"));
            }

            final events = snapshot.data!.events!;

            return ListView.builder(
              controller: scrollController,
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return EventCard(event: event);
              },
            );
          },
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Events event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () => Get.to(() => EventDetailView(event: event)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          if (event.image != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                event.image!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 8),
          Text(
            event.title ?? 'Judul Tidak Tersedia',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Tanggal: ${event.tglMulai ?? 'Belum ditentukan'}',
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          if (event.kategori?.kategori != null)
            Text(
              'Kategori: ${event.kategori!.kategori!}',
              style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
            ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.red),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  event.lokasi ?? 'Lokasi Tidak Tersedia',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
        ],
      ),
    );
  }
}
