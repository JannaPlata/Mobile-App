import 'package:flutter/material.dart';

class GoogleSignInScreen extends StatelessWidget {
  const GoogleSignInScreen({super.key});
  void _onNavTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/'); // home
        break;
      case 1:
        // Add reservation screen later
        break;
      case 2:
        Navigator.pushNamed(context, '/profile'); // profile
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) => _onNavTapped(context, index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            right: 20,
            bottom: 80,
            child: Image.asset("assets/images/shape_bg.png", width: 80),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Sign-in to Rosario Resort and Hotel",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text("Welcome back! Please sign in to continue"),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: Image.asset("assets/images/google.png", height: 20),
                  label: const Text("Continue with Google"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 45),
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    // Handle Google Sign-in
                  },
                ),
                const SizedBox(height: 15),
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("or"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 15),
                const Text("Email Address"),
                const TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your Email Address",
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    // Handle continue
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: const Text("Continue →"),
                ),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Go to sign-up
                    },
                    child: const Text("Don't have an account? Sign-up"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
