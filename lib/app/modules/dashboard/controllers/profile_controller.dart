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
        Uri.parse('http://127.0.0.1:8000/api/user'),
        headers: {
          'Authorization': 'Bearer 3|H9JvbIdew73yWfKHK2dXAbCxjvm5c8jtGA2gvZyse6ecf103',
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
