import 'package:flutter/material.dart';
import 'package:myapp/home_screen.dart';

class VerifikasiScreen extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'VERIFIKASI',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Demi keamanan akun dan informasi terkait, silahkan masukkan kode OTP yang dikirim melalui Email Anda.',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: otpController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Masukkan 6 digit kode OTP',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 6, // Membatasi input hingga 6 digit
                ),
                SizedBox(height: 20),
                Text(
                  'Kode OTP yang dikirim valid dalam 01:00',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String otp = otpController.text;
                    if (otp.length == 6 && RegExp(r'^[0-9]+$').hasMatch(otp)) {
                      // Jika OTP benar (6 digit angka), lakukan navigasi ke beranda
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } else {
                      // Jika OTP tidak valid, tampilkan pesan error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Kode OTP harus berupa 6 digit angka'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Text('VERIFIKASI'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
