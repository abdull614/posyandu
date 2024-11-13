// profil_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/model/profil_model.dart';

class ProfilService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Menyimpan atau memperbarui profil
  Future<void> saveProfil(Profil profil) async {
    await _firestore.collection('profil').doc(profil.id).set(profil.toMap());
  }

  // Mengambil profil berdasarkan ID
  Future<Profil?> getProfil(String id) async {
    DocumentSnapshot snapshot = await _firestore.collection('profil').doc(id).get();
    if (snapshot.exists) {
      return Profil.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id);
    }
    return null;
  }
}