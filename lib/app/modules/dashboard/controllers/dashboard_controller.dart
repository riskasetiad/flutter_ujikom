import 'package:eventway_p5/app/data/event_response.dart';
import 'package:eventway_p5/app/modules/dashboard/views/index_view.dart';
import 'package:eventway_p5/app/modules/dashboard/views/kategori_view.dart';
import 'package:eventway_p5/app/modules/dashboard/views/profile_view.dart';
import 'package:eventway_p5/app/modules/dashboard/views/your_event_view.dart';
import 'package:eventway_p5/app/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController {
  final _getConnect = GetConnect();
  final token = GetStorage().read('token');

  // Reactive loading state
  var isLoading = false.obs;

  // Untuk event yang ditampilkan di halaman utama
  late Future<EventResponse> eventFuture;

  // Untuk event milik pengguna
  var yourEvents = <Events>[].obs;

  // Untuk navigasi tab
  var selectedIndex = 0.obs;

  // Halaman-halaman dashboard
  final List<Widget> pages = [
    IndexView(),
    KategoriView(),
    ProfileView(),
  ];

  /// Ambil semua event (Index)
  Future<EventResponse> getEvent() async {
    try {
      // isLoading.value = true;
      final response = await _getConnect.get(
        BaseUrl.event,
        headers: {'Authorization': 'Bearer $token'},
        contentType: "application/json",
      );

      print("EVENT RESPONSE: ${response.body}");
      print("STATUS CODE: ${response.statusCode}");

      if (response.statusCode == 200) {
        return EventResponse.fromJson(response.body);
      } else {
        throw Exception("Gagal memuat event, kode: ${response.statusCode}");
      }
    } catch (e) {
      print("Error saat mengambil event: $e");
      throw Exception("Terjadi kesalahan saat mengambil event");
    } finally {
      isLoading.value = false;
    }
  }

  /// Ambil event milik user
  Future<void> getYourEvent() async {
    try {
      final response = await _getConnect.get(
        BaseUrl.yourEvent,
        headers: {'Authorization': 'Bearer $token'},
        contentType: "application/json",
      );

      if (response.statusCode == 200) {
        final eventResponse = EventResponse.fromJson(response.body);
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
    eventFuture = getEvent();
    getYourEvent();
  }
}
