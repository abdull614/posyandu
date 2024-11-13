import 'package:flutter/material.dart';

class HasilJadwal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Imunisasi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'KIRANA DEWI',
                border: OutlineInputBorder(),
                enabled: false,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Tegalan Rt 01/04 Cuplk, Sukoharjo',
                border: OutlineInputBorder(),
                enabled: false,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Kategori: Balita',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle 'Jadwal Imunisasi' button press
                    },
                    child: Text('JADWAL IMUNISASI'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle 'SIMPAN' button press
                    },
                    child: Text('SIMPAN'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}