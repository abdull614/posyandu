import 'dart:io'; // Tambahkan ini untuk menggunakan File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/home_screen.dart';
import 'package:myapp/jadwal_screen.dart';
import 'package:myapp/notif_screen.dart';
import 'package:myapp/login_screen.dart';
import 'package:myapp/konsultasi.dart';
import 'package:myapp/catatan_imunisasi.dart';
import 'package:myapp/ubah_profil.dart';
import 'package:myapp/service/profil_service.dart';
import 'package:myapp/model/profil_model.dart';

class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  int _selectedIndex = 3;
  String _userName = 'Dessy Purwanti';
  String _userAddress = 'Bulakan';
  String _profileImage = 'assets/images/user.png';
  final ProfilService profilService = ProfilService();
  final ImagePicker _picker = ImagePicker(); // Inisialisasi ImagePicker

  @override
  void initState() {
    super.initState();
    _loadUserProfile(); // Panggil fungsi untuk memuat profil pengguna
  }

  Future<void> _loadUserProfile() async {
    // Ganti 'user_id_here' dengan ID pengguna yang sesuai
    Profil? profil = await profilService.getProfil('user_id_here');
    if (profil != null) {
      setState(() {
        _userName = profil.nama; // Update nama pengguna
        _userAddress = profil.alamat; // Update alamat pengguna
        // Jika ada gambar profil di model, tambahkan di sini
        //_profileImage = profil.gambar; // Misalnya jika ada field gambar
      });
    }
  }

  Future<void> _changeProfileImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile.path; // Update gambar profil dengan path gambar
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _changeProfileImage, // Panggil fungsi untuk mengganti gambar profil
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(File(_profileImage)),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _userName,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                _userAddress,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UbahProfilScreen(
                        initialName: _userName,
                        initialAddress: _userAddress,
                        userId: 'user_id_here', // Ganti dengan ID pengguna yang sesuai
                      ),
                    ),
                  ).then((_) {
                    _loadUserProfile(); // Memuat ulang profil setelah kembali
                  });
                },
                child: const Text('Ubah Profil'),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text('Catatan Imunisasi'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImmunizationHistory()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.medical_services),
                title: const Text('Konsultasi'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => KonsultasiPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Keluar'),
                onTap: () {
                  _showLogoutConfirmation(context);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
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
            _selectedIndex = index;
          });

          switch (index) {
            case 0:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => JadwalScreen(onReturn: () {}),
                ),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => NotifScreen(notificationMessage: 'Your notification message here'),
                ),
              );
              break;
            case 3:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilScreen()));
              break;
          }
        },
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }
}