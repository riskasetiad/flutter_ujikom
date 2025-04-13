import 'package:eventway_p5/app/data/event_response.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class EventDetailView extends GetView {
  const EventDetailView({super.key, required Events event});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EventDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EventDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
