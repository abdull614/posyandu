import 'package:flutter/material.dart';


class ImmunizationHistory extends StatelessWidget {
  final List<String> immunizationDates = [
    'Rabu 23 Desember 2024',
    'Senin 28 Desember 2024',
    'Jum\'at 6 Januari 2025',
    'Selasa 10 Januari 2025',
    'Kamis 21 Januari 2025',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catatan Imunisasi'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'History Hari Imunisasi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: immunizationDates.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(immunizationDates[index]),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Action when the date is tapped, if needed
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
