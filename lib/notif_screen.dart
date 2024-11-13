import 'package:flutter/material.dart';
import 'package:myapp/home_screen.dart';
import 'package:myapp/jadwal_screen.dart';
import 'package:myapp/profil.dart';

class NotifScreen extends StatefulWidget {
  final String notificationMessage;

  const NotifScreen({Key? key, required this.notificationMessage}) : super(key: key);

  @override
  _NotifScreenState createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {
  int _selectedIndex = 2;
  List<String> notifications = []; // Daftar untuk menyimpan notifikasi

  @override
  void initState() {
    super.initState();
    // Tambahkan pesan notifikasi ke dalam daftar
    notifications.add(widget.notificationMessage);
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => JadwalScreen(onReturn: () {  },)),
        );
        break;
      case 2:
        // Tetap di NotifScreen
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return buildNotifTile(notifications[index]);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifikasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Perbarui indeks yang dipilih
          });
          _onItemTapped(index); // Panggil fungsi navigasi
        },
      ),
    );
  }

  Widget buildNotifTile(String message) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}