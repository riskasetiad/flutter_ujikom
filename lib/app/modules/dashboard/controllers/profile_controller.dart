import 'dart:convert';
import 'package:eventway_p5/app/data/profile_response.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  var profile = ProfileResponse().obs;
  var isLoading = false.obs;

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
          'Authorization': 'Bearer 104|xu3CJpT58DfeQfPsW3Z5fY7V7dRCXP40LQmP7WJ2246df23c',
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
}
