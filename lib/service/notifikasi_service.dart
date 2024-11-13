// lib/services/notifikasi_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/balita_model.dart';
import '../model/lansia_model.dart';
import '../model/ibu_hamil_model.dart';

class NotifikasiService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<dynamic>> fetchData(String collection) async {
    try {
      final QuerySnapshot snapshot = await _db.collection(collection).get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        switch (collection) {
          case 'balita':
            return Balita.fromMap({...data, 'id': doc.id});
          case 'lansia':
            return Lansia.fromMap({...data, 'id': doc.id});
          case 'ibu_hamil':
            return IbuHamil.fromMap({...data, 'id': doc.id});
          default:
            throw Exception('Koleksi tidak dikenal');
        }
      }).toList();
    } catch (e) {
      throw Exception('Gagal memuat data: $e');
    }
  }
}