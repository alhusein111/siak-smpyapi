class SiswaModel {
  final String id;
  final String nis;
  final String nisn;
  final String nama;
  final String kelas;
  final String jenisKelamin;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SiswaModel({
    required this.id,
    required this.nis,
    required this.nisn,
    required this.nama,
    required this.kelas,
    required this.jenisKelamin,
    this.createdAt,
    this.updatedAt,
  });

  // Konversi dari JSON (NestJS Response) ke Objek Dart
  factory SiswaModel.fromJson(Map<String, dynamic> json) {
    return SiswaModel(
      id: json['id'] as String,
      nis: json['nis'] as String,
      nisn: json['nisn'] as String,
      nama: json['nama'] as String,
      kelas: json['kelas'] as String,
      jenisKelamin: json['jenisKelamin'] as String,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  // Konversi dari Objek Dart ke JSON (Payload Request ke NestJS)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nis': nis,
      'nisn': nisn,
      'nama': nama,
      'kelas': kelas,
      'jenisKelamin': jenisKelamin,
    };
  }
}