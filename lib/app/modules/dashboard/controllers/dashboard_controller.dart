import 'package:dio/dio.dart';
import 'package:eventway_p5/app/data/event_response.dart';
import 'package:eventway_p5/app/modules/dashboard/views/index_view.dart';
import 'package:eventway_p5/app/modules/dashboard/views/kategori_view.dart';
import 'package:eventway_p5/app/modules/dashboard/views/profile_view.dart';
import 'package:eventway_p5/app/modules/dashboard/views/your_event_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController {
  final Dio dio = Dio();
  final token = GetStorage().read('token');

  // Reactive state untuk loading
  var isLoading = false.obs;

  // Untuk event yang ditampilkan di halaman utama
  late Future<EventResponse> eventFuture;

  // Untuk event milik pengguna
  var yourEvents = <Events>[].obs;

  // Reactive state untuk navigasi tab
  var selectedIndex = 0.obs;

  // Halaman-halaman dashboard
  final List<Widget> pages = [
    IndexView(),
    YourEventView(),
    ProfileView(),
    KategoriView(),
  ];

  /// Ambil semua event (Index)
  Future<EventResponse> getEvent() async {
    try {
      final response = await dio.get(
        'http:///192.168.0.162:8000/api/events', // URL API
        options: Options(
          headers: {'Authorization': 'Bearer 125|GemcvOa633Fmbu9UuvAJ3xMTcNftfXI9ybS4ym8U6b24b405'},
          contentType: 'application/json',
        ),
      );

      print("EVENT RESPONSE: ${response.data}");
      print("STATUS CODE: ${response.statusCode}");

      if (response.statusCode == 200) {
        return EventResponse.fromJson(response.data);
      } else {
        throw Exception("Gagal memuat event, kode: ${response.statusCode}");
      }
    } catch (e) {
      print("Error saat mengambil event: $e");
      throw Exception("Terjadi kesalahan saat mengambil event");
    }
  }

  /// Ambil event milik user
  Future<void> getYourEvent() async {
    try {
      final response = await dio.get(
        'http:///192.168.0.162:8000/api/your-event', // URL API
        options: Options(
          headers: {'Authorization': 'Bearer 125|GemcvOa633Fmbu9UuvAJ3xMTcNftfXI9ybS4ym8U6b24b405'},
          contentType: 'application/json',
        ),
      );

      if (response.statusCode == 200) {
        final eventResponse = EventResponse.fromJson(response.data);
        yourEvents.value = eventResponse.events ?? [];
      } else {
        print("Gagal memuat event Anda, kode: ${response.statusCode}");
      }
    } catch (e) {
      print("Error saat mengambil event milik user: $e");
    }
  }

  /// Refresh semua event (gunakan untuk pull-to-refresh)
  Future<void> refreshEvents() async {
    eventFuture = getEvent();
    await getYourEvent();
  }

  /// Ganti tab bottom nav
  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    eventFuture = getEvent(); // Ambil semua event
    getYourEvent(); // Ambil event milik pengguna
  }
}
