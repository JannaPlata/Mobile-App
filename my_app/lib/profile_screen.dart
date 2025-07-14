import 'package:flutter/material.dart';
import 'home.dart';  // For HotelHomePage navigation
import 'room_search.dart'; // For RoomListPage navigation
import 'login_screen.dart'; // <-- Import LoginScreen

class ProfileScreen extends StatelessWidget {
  final String username;

  const ProfileScreen({super.key, required this.username});

  void _onNavTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HotelHomePage(username: username)),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RoomListPage()),
        );
        break;
      case 2:
        // Already on profile
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) => _onNavTapped(context, index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 10,
            right: 10,
            child: Image.asset("assets/images/shape_bg1.png", width: 360),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Image.asset("assets/images/shape_bg.png", width: 400),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 50),
                ),
                const SizedBox(height: 10),

                // Show the dynamic username here
                Text(username, style: const TextStyle(fontSize: 18)),

                TextButton(onPressed: () {}, child: const Text("Edit name")),
                const SizedBox(height: 20),
                buildOptionTile(Icons.settings, "Manage account", () {}),
                buildOptionTile(Icons.room_service, "My Reservations", () {}),
                buildOptionTile(Icons.logout, "Sign-out", () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOptionTile(IconData icon, String label, VoidCallback onTap) {
    return Card(
      child: ListTile(leading: Icon(icon), title: Text(label), onTap: onTap),
    );
  }
}
