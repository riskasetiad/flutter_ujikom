import 'dart:convert';
import 'package:eventway_p5/app/data/profile_response.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  var profile = ProfileResponse().obs;
  var isLoading = false.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  void fetchProfile() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse('http://192.168.0.162:8000/api/user'),
        headers: {
          'Authorization': 'Bearer 125|GemcvOa633Fmbu9UuvAJ3xMTcNftfXI9ybS4ym8U6b24b405',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        profile.value = ProfileResponse.fromJson(data);
      } else {
        Get.snackbar('Error', 'Gagal memuat data profil');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    box.erase(); // Hapus semua data dari GetStorage
    Get.offAllNamed('/login'); // Arahkan kembali ke halaman login
  }
}
