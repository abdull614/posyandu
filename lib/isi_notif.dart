// lib/screens/isi_notif.dart
import 'package:flutter/material.dart';
import 'package:myapp/service/notifikasi_service.dart';

class IsiNotifScreen extends StatelessWidget {
  final String collection;

  const IsiNotifScreen({Key? key, required this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifikasiService = NotifikasiService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendaftaran Imunisasi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: notifikasiService.fetchData(collection),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data pendaftaran.'));
          }

          final dataList = snapshot.data!;
          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final item = dataList[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama: ${item.nama}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Alamat: ${item.alamat}'),
                      const SizedBox(height: 4),
                      Text('Tanggal Imunisasi: ${item.tanggalImunisasi.toLocal().toString().split(' ')[0]}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}