// profil_model.dart
class Profil {
  String id; // ID untuk dokumen di Firestore
  String nama;
  String alamat;

  Profil({
    required this.id,
    required this.nama,
    required this.alamat,
  });

  // Konversi dari map ke objek Profil
  factory Profil.fromMap(Map<String, dynamic> data, String documentId) {
    return Profil(
      id: documentId,
      nama: data['nama'],
      alamat: data['alamat'],
    );
  }

  // Konversi dari objek Profil ke map
  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'alamat': alamat,
    };
  }
}