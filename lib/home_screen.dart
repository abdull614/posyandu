import 'package:flutter/material.dart';
import 'jadwal_ibu_hamil.dart'; // Import Jadwal Ibu Hamil
import 'jadwal_balita.dart'; // Import Jadwal Balita
import 'jadwal_lansia.dart'; // Import Jadwal Lansia
import 'jadwal_screen.dart'; // Import jadwal screen
import 'notif_screen.dart';  // Import notif screen
import 'profil.dart';     // Import profil screen

class HomeScreen extends StatefulWidget {
  final String userName;
  final String userAddress;

  HomeScreen({this.userName = '', this.userAddress = ''});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Hallo ${widget.userName}'),
        backgroundColor: Colors.blue,
        // Hapus atau tidak perlu menambahkan actions di sini
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: BottomWaveClipper(),
            child: Container(
              height: 180,
              color: Colors.blue,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'KATEGORI',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCategoryButton(context, 'I', 'IBU HAMIL', 'ibu_hamil'),
                          _buildCategoryButton(context, 'B', 'BALITA', 'balita'),
                          _buildCategoryButton(context, 'L', 'LANSIA', 'lansia'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildImageCard('assets/images/1.png'),
                    _buildImageCard('assets/images/2.jpeg'),
                    _buildImageCard('assets/images/3.jpg'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => JadwalScreen(onReturn: () {})));
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => NotifScreen(notificationMessage: 'You have new notifications!'),
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

  Widget _buildCategoryButton(BuildContext context, String letter, String label, String category) {
    return GestureDetector(
      onTap: () {
        // Navigasi sesuai kategori
        switch (category) {
          case 'ibu_hamil':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => JadwalIbuHamil()),
            );
            break;
          case 'balita':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => JadwalBalita()),
            );
            break;
          case 'lansia':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => JadwalLansia()),
            );
            break;
          default:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryDetailScreen(label: label),
              ),
            );
            break;//
        }
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.grey[300],
            child: Text(
              letter,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          height: 150,
        ),
      ),
    );
  }
}

// Custom Clipper for creating a curved background
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 50);

    path.quadraticBezierTo(
        firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Sample screen for category detail
class CategoryDetailScreen extends StatelessWidget {
  final String label;

  CategoryDetailScreen({required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: Center(
        child: Text(
          'Detail for $label',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
