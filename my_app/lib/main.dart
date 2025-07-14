import 'package:flutter/material.dart';
import 'package:my_app/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: '901867556693-i3ijjus5t2f5kj916l4n7ioe5njseg6g.apps.googleusercontent.com',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
