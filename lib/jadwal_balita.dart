import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/notif_screen.dart'; // Pastikan file ini ada
import 'package:myapp/model/balita_model.dart'; // Pastikan file ini ada
import 'package:myapp/service/imunisasi_service.dart'; // Pastikan file ini ada

class JadwalBalita extends StatefulWidget {
  @override
  _JadwalBalitaState createState() => _JadwalBalitaState();
}

class _JadwalBalitaState extends State<JadwalBalita> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  DateTime? _selectedDate;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final ImunisasiService _imunisasiService = ImunisasiService();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Tanggal pertama yang dapat dipilih adalah hari ini
      lastDate: DateTime(2100), // Tanggal terakhir yang dapat dipilih
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = _dateFormat.format(_selectedDate!);
      });
    }
  }

  void _validateAndSubmit() async {
    try {
      if (_dateController.text.isNotEmpty) {
        DateTime manualDate = _dateFormat.parseStrict(_dateController.text);
        setState(() {
          _selectedDate = manualDate;
        });

        // Membuat objek Balita
        Balita balita = Balita(
          nama: _nameController.text,
          alamat: _addressController.text,
          tanggalImunisasi: _selectedDate!,
        );

        // Simpan data ke Firestore
        await _imunisasiService.addBalita(balita);

        // Siapkan pesan notifikasi
        String notifMessage = 'Pendaftaran imunisasi berhasil disimpan:\n'
            'Nama: ${balita.nama}\n'
            'Alamat: ${balita.alamat}\n'
            'Tanggal Imunisasi: ${_dateFormat.format(balita.tanggalImunisasi)}';

        // Navigasi ke NotifScreen dengan pesan notifikasi
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NotifScreen(notificationMessage: notifMessage),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Silakan isi tanggal imunisasi')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Format tanggal salah. Gunakan format dd/MM/yyyy'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Balita'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('Masukkan Nama'),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nama Balita',
              ),
            ),
            const SizedBox(height: 20),
            const Text('Alamat'),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Alamat Balita',
              ),
            ),
            const SizedBox(height: 20),
            const Text('Tanggal Imunisasi'),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      hintText: 'DD/MM/YYYY',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    onChanged: (value) {
                      String newValue =
                          value.replaceAll(RegExp(r'[^0-9/]'), '');

                      if (newValue.length >= 2 && newValue[2] != '/') {
                        newValue = newValue.substring(0, 2) +
                            '/' +
                            newValue.substring(2);
                      }
                      if (newValue.length >= 5 && newValue[5] != '/') {
                        newValue = newValue.substring(0, 5) +
                            '/' +
                            newValue.substring(5);
                      }

                      _dateController.text = newValue;
                      _dateController.selection = TextSelection.fromPosition(
                          TextPosition(offset: newValue.length));
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: _validateAndSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text('SIMPAN'),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue[50],
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}