import 'package:cloud_firestore/cloud_firestore.dart';

class IbuHamil {
  String? id;
  String nama;
  String alamat;
  DateTime tanggalImunisasi;

  IbuHamil({
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

  factory IbuHamil.fromMap(Map<String, dynamic> map) {
    return IbuHamil(
      id: map['id'],
      nama: map['nama'],
      alamat: map['alamat'],
      tanggalImunisasi: (map['tanggal_imunisasi'] as Timestamp).toDate(),
    );
  }
}