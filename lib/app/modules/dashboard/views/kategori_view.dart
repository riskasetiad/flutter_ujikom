import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/kategori_controller.dart';

class KategoriView extends StatefulWidget {
  const KategoriView({super.key});

  @override
  State<KategoriView> createState() => _KategoriViewState();
}

class _KategoriViewState extends State<KategoriView> {
  final KategoriController kategoriController = Get.put(KategoriController());
  final TextEditingController namaKategoriController = TextEditingController();

  @override
  void initState() {
    super.initState();
    kategoriController.fetchKategoriData(); // Ambil data saat pertama tampil
  }

  @override
  void dispose() {
    namaKategoriController.dispose(); // Hindari memory leak
    super.dispose();
  }

  Future<void> _tambahKategori() async {
    final nama = namaKategoriController.text.trim();
    if (nama.isEmpty) {
      Get.snackbar('Error', 'Nama kategori tidak boleh kosong');
      return;
    }

    await kategoriController.createKategori(nama);
    namaKategoriController.clear();
    await kategoriController.fetchKategoriData(); // Refresh daftar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kategori'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (kategoriController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tambah Kategori',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: namaKategoriController,
                decoration: const InputDecoration(
                  labelText: 'Nama Kategori',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _tambahKategori,
                child: const Text('Tambah Kategori'),
              ),
              const SizedBox(height: 24),
              const Text(
                'Daftar Kategori',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(child: KategoriList()),
            ],
          ),
        );
      }),
    );
  }
}

class KategoriList extends StatelessWidget {
  final KategoriController kategoriController = Get.find<KategoriController>();

  KategoriList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (kategoriController.kategoriList.isEmpty) {
        return const Center(child: Text('Belum ada kategori.'));
      }

      return ListView.builder(
        itemCount: kategoriController.kategoriList.length,
        itemBuilder: (context, index) {
          final kategori = kategoriController.kategoriList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              title: Text(kategori.namaKategori ?? 'No name'),
            ),
          );
        },
      );
    });
  }
}
