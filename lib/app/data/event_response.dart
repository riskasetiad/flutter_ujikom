class EventResponse {
  bool? success;
  String? message;
  List<Events>? events;

  EventResponse({this.success, this.message, this.events});

  EventResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      events = <Events>[];
      json['data'].forEach((v) {
        events!.add(Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    if (events != null) {
      data['data'] = events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
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
  dynamic alasan;
  String? slug;
  String? createdAt;
  String? updatedAt;
  Kategori? kategori;

  Events({
    this.id,
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
    this.updatedAt,
    this.kategori,
  });

  Events.fromJson(Map<String, dynamic> json) {
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
    kategori =
        json['kategori'] != null ? Kategori.fromJson(json['kategori']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['image'] = image;
    data['title'] = title;
    data['kategori_id'] = kategoriId;
    data['tgl_mulai'] = tglMulai;
    data['tgl_selesai'] = tglSelesai;
    data['kota'] = kota;
    data['lokasi'] = lokasi;
    data['url_lokasi'] = urlLokasi;
    data['deskripsi'] = deskripsi;
    data['waktu_mulai'] = waktuMulai;
    data['waktu_selesai'] = waktuSelesai;
    data['status'] = status;
    data['alasan'] = alasan;
    data['slug'] = slug;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (kategori != null) {
      data['kategori'] = kategori!.toJson();
    }
    return data;
  }
}

class Kategori {
  int? id;
  String? kategori;
  String? createdAt;
  String? updatedAt;

  Kategori({this.id, this.kategori, this.createdAt, this.updatedAt});

  Kategori.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kategori = json['kategori'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['kategori'] = kategori;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
