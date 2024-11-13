import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/model/profil_model.dart';
import 'package:myapp/service/profil_service.dart';

class UbahProfilScreen extends StatefulWidget {
  final String initialName;
  final String initialAddress;
  final String userId; // ID pengguna untuk memperbarui profil

  UbahProfilScreen({
    required this.initialName,
    required this.initialAddress,
    required this.userId,
  });

  @override
  _UbahProfilScreenState createState() => _UbahProfilScreenState();
}

class _UbahProfilScreenState extends State<UbahProfilScreen> {
  final ProfilService profilService = ProfilService();
  late TextEditingController nameController;
  late TextEditingController addressController;
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialName);
    addressController = TextEditingController(text: widget.initialAddress);
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Profil'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : AssetImage('assets/images/user.png') as ImageProvider,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                ),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  Profil profil = Profil(
                    id: widget.userId,
                    nama: nameController.text,
                    alamat: addressController.text,
                  );

                  // Simpan profil, termasuk gambar
                  await profilService.saveProfil(profil);
                  // Jika Anda ingin menyimpan gambar, tambahkan logika di sini
                  
                  Navigator.pop(context);
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}