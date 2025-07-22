import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPasswordScreen extends StatefulWidget {
  final String token;
  const ResetPasswordScreen({super.key, required this.token});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _message = '';

  Future<void> resetPassword() async {
    final newPassword = _passwordController.text.trim();

    if (newPassword.length < 6) {
      setState(() => _message = "Password must be at least 6 characters.");
      return;
    }

    setState(() {
      _isLoading = true;
      _message = '';
    });

    // Verify the token
    final verifyResponse = await http.post(
      Uri.parse('http://rosarioresortshotel.alwaysdata.net/verify_token.php'),
      body: {'token': widget.token},
    );

    final verifyData = json.decode(verifyResponse.body);

    if (verifyData['status'] != 'valid') {
      setState(() {
        _isLoading = false;
        _message = verifyData['message'];
      });
      return;
    }

    // Reset the password
    final resetResponse = await http.post(
      Uri.parse('http://rosarioresortshotel.alwaysdata.net/reset_password_api.php'),
      body: {'token': widget.token, 'password': newPassword},
    );

    final resetData = json.decode(resetResponse.body);

    setState(() {
      _isLoading = false;
      _message = resetData['message'];
    });

    if (resetData['status'] == 'success') {
      // redirect to login screen
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context); //  push login screen
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter a new password for your account.",
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "New Password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : resetPassword,
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text("Reset Password"),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  _message,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: _message.toLowerCase().contains("success")
                        ? Colors.green
                        : Colors.redAccent,
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
