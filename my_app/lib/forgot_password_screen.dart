import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String _message = '';

  Future<void> sendResetEmail() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(() => _message = "Please enter your email.");
      return;
    }

    setState(() => _isLoading = true);
    final response = await http.post(
      Uri.parse("http://10.0.2.2/db_rosario/forgot_password.php"),
      body: {'email': email},
    );

    setState(() {
      _isLoading = false;
      _message = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Enter your registered email to receive a reset link.",
                style: GoogleFonts.poppins(fontSize: 14)),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: const Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : sendResetEmail,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Send Reset Link"),
            ),
            const SizedBox(height: 20),
            Text(_message,
                style: GoogleFonts.poppins(
                    color: Colors.redAccent, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
