import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          // Navigation logic
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 60,
            right: 20,
            child: Image.asset("assets/images/shape_bg.png", width: 60),
          ),
          Positioned(
            bottom: 100,
            left: 10,
            child: Image.asset("assets/images/shape_bg.png", width: 60),
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
                const Text("Name", style: TextStyle(fontSize: 18)),
                TextButton(onPressed: () {}, child: const Text("Edit name")),
                const SizedBox(height: 20),
                buildOptionTile(Icons.settings, "Manage account", () {}),
                buildOptionTile(Icons.room_service, "My Reservations", () {}),
                buildOptionTile(Icons.logout, "Sign-out", () {
                  Navigator.pop(context);
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
