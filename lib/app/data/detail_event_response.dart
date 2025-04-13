class DetailEventResponse {
  int? id;
  int? userId;
  String? image;
  String? title;
  int? kategoriId;
  String? tglMulai;
  String? tglSelesai;
  String? kota;
  String? lokasi;
  String? urlLokasi;
  String? deskripsi;
  String? waktuMulai;
  String? waktuSelesai;
  String? status;
  String? alasan;
  String? slug;
  String? createdAt;
  String? updatedAt;

  DetailEventResponse(
      {this.id,
      this.userId,
      this.image,
      this.title,
      this.kategoriId,
      this.tglMulai,
      this.tglSelesai,
      this.kota,
      this.lokasi,
      this.urlLokasi,
      this.deskripsi,
      this.waktuMulai,
      this.waktuSelesai,
      this.status,
      this.alasan,
      this.slug,
      this.createdAt,
      this.updatedAt});

  DetailEventResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
    title = json['title'];
    kategoriId = json['kategori_id'];
    tglMulai = json['tgl_mulai'];
    tglSelesai = json['tgl_selesai'];
    kota = json['kota'];
    lokasi = json['lokasi'];
    urlLokasi = json['url_lokasi'];
    deskripsi = json['deskripsi'];
    waktuMulai = json['waktu_mulai'];
    waktuSelesai = json['waktu_selesai'];
    status = json['status'];
    alasan = json['alasan'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    data['title'] = this.title;
    data['kategori_id'] = this.kategoriId;
    data['tgl_mulai'] = this.tglMulai;
    data['tgl_selesai'] = this.tglSelesai;
    data['kota'] = this.kota;
    data['lokasi'] = this.lokasi;
    data['url_lokasi'] = this.urlLokasi;
    data['deskripsi'] = this.deskripsi;
    data['waktu_mulai'] = this.waktuMulai;
    data['waktu_selesai'] = this.waktuSelesai;
    data['status'] = this.status;
    data['alasan'] = this.alasan;
    data['slug'] = this.slug;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
