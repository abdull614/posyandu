import 'package:cloud_firestore/cloud_firestore.dart';

class Lansia {
  String? id;
  String nama;
  String alamat;
  DateTime tanggalImunisasi;

  Lansia({
    this.id,
    required this.nama,
    required this.alamat,
    required this.tanggalImunisasi,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'alamat': alamat,
      'tanggal_imunisasi': tanggalImunisasi,
    };
  }

  factory Lansia.fromMap(Map<String, dynamic> map) {
    return Lansia(
      id: map['id'],
      nama: map['nama'],
      alamat: map['alamat'],
      tanggalImunisasi: (map['tanggal_imunisasi'] as Timestamp).toDate(),
    );
  }
}