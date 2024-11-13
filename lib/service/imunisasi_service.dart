// imunisasi_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/model/ibu_hamil_model.dart';
import 'package:myapp/model/lansia_model.dart';
import 'package:myapp/model/balita_model.dart';

class ImunisasiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Menyimpan data Ibu Hamil
  Future<void> addIbuHamil(IbuHamil ibuHamil) async {
    await _firestore.collection('ibu_hamil').add(ibuHamil.toMap());
  }

  // Menyimpan data Lansia
  Future<void> addLansia(Lansia lansia) async {
    await _firestore.collection('lansia').add(lansia.toMap());
  }

  // Menyimpan data Balita
  Future<void> addBalita(Balita balita) async {
    await _firestore.collection('balita').add(balita.toMap());
  }
}