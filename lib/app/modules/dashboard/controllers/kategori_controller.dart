import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../data/kategori_response.dart';
import '../../../utils/api.dart';

class KategoriController extends GetxController {
  var isLoading = false.obs;
  var kategoriList = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchKategoriData(); // Ambil data saat controller pertama kali dibuat
  }

  // Ambil data kategori dari API
  Future<void> fetchKategoriData() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(BaseUrl.kategori));

      if (response.statusCode == 200) {
        final kategoriResponse = Kategori.fromJson(json.decode(response.body));

        if (kategoriResponse.data != null) {
          kategoriList.value = kategoriResponse.data!;
        } else {
          kategoriList.clear();
          Get.snackbar('Info', 'Tidak ada data kategori tersedia');
        }
      } else {
        Get.snackbar(
          'Error',
          'Gagal mengambil data kategori. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan saat mengambil data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk menambah kategori baru
  Future<void> createKategori(String namaKategori) async {
    try {
      final response = await http.post(
        Uri.parse(BaseUrl.kategori),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'kategori': namaKategori}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final kategoriResponse = Kategori.fromJson(json.decode(response.body));

        if (kategoriResponse.success == true) {
          Get.snackbar(
            'Sukses',
            kategoriResponse.message ?? 'Berhasil menambahkan',
            snackPosition: SnackPosition.BOTTOM,
          );

          // Cek apakah ada data yang bisa ditambahkan langsung
          final newData = kategoriResponse.data;
          if (newData != null && newData.isNotEmpty) {
            // Cek apakah sudah ada di list (hindari duplikat)
            final alreadyExists =
                kategoriList.any((element) => element.id == newData.first.id);
            if (!alreadyExists) {
              kategoriList.add(newData.first);
            }
          } else {
            // Kalau tidak ada data baru dikembalikan, fetch ulang
            await fetchKategoriData();
          }
        } else {
          Get.snackbar(
            'Gagal',
            kategoriResponse.message ?? 'Penambahan gagal',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          'Gagal',
          'Status Code: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
