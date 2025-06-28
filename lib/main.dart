import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const RosarioApp());
}

class RosarioApp extends StatelessWidget {
  const RosarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rosario Hotel & Resorts',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WelcomeScreen(),
    );
  }
}
