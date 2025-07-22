import 'package:flutter/material.dart';
import 'home.dart';
import 'room_search.dart';
import 'login_screen.dart';
import 'manage_accounts.dart'; // <-- Import ManageAccountScreen
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = '';
  String _email = '';
  String _phone = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
      _email = prefs.getString('email') ?? '';
      _phone = prefs.getString('phone') ?? '';
    });
  }

  void _onNavTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HotelHomePage(),
          ),
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

  Future<void> _openManageAccount() async {
    print("ProfileScreen: username=$_username, email=$_email, phone=$_phone");
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManageAccountScreen(
          initialUsername: _username,
          initialEmail: _email,
          initialPhone: _phone,
        ),
      ),
    );

    if (result != null && mounted) {
      // Reload user info from SharedPreferences
      await _loadUserInfo();
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

                Text(_username, style: const TextStyle(fontSize: 18)),
                // Removed email and phone display from profile screen
                const SizedBox(height: 20),
                buildOptionTile(
                  Icons.settings,
                  "Manage account",
                  _openManageAccount,
                ),
                buildOptionTile(Icons.logout, "Sign-out", () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
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