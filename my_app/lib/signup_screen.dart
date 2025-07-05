import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreeTerms = false;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> _registerUser() async {
  if (fullNameController.text.trim().isEmpty ||
      emailController.text.trim().isEmpty ||
      phoneController.text.trim().isEmpty ||
      passwordController.text.trim().isEmpty ||
      confirmPasswordController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please fill in all fields.")),
    );
    return;
  }

  if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Passwords do not match.")),
    );
    return;
  }

  if (!_agreeTerms) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("You must agree to the terms.")),
    );
    return;
  }

  const String url = 'http://10.0.2.2/db_rosario/register.php';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "full_name": fullNameController.text.trim(),
        "email": emailController.text.trim(),
        "phone": phoneController.text.trim(),
        "password": passwordController.text.trim(),
      }),
    );

    final data = jsonDecode(response.body);
    if (data["success"]) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration successful")),
      );
      Navigator.pop(context); // Return to login screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data["message"] ?? "Registration failed")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF58CAFF), Color(0xFF1B4F72)],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Center(child: Image.asset('assets/logo.png', height: 100)),
                const SizedBox(height: 15),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFFF0F0F0), Color(0xFFFFFFFF)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds),
                  child: Text(
                    'Welcome to\nRosario Resorts and Hotel!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      shadows: const [
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF3A8CB6), Color(0xFF1F4960)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    'Creating your staycation starts here.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      shadows: const [
                        Shadow(
                          color: Colors.black45,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 40,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: fullNameController,
                        style: GoogleFonts.poppins(fontSize: 14),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          hintText: 'Full Name',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: emailController,
                        style: GoogleFonts.poppins(fontSize: 14),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          hintText: 'Email Address',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: phoneController,
                        style: GoogleFonts.poppins(fontSize: 14),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          hintText: 'Phone Number',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        obscureText: _obscurePassword,
                        style: GoogleFonts.poppins(fontSize: 14),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          hintText: 'Password',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: _obscureConfirm,
                        style: GoogleFonts.poppins(fontSize: 14),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          hintText: 'Confirm Password',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirm
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirm = !_obscureConfirm;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Checkbox(
                            value: _agreeTerms,
                            onChanged: (value) {
                              setState(() {
                                _agreeTerms = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              "I agree to the Terms & Conditions",
                              style: GoogleFonts.poppins(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xFF3D93C0), Color(0xFF1D455A)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: TextButton(
                          onPressed: _registerUser,
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            "SIGN UP",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 64,
                            height: 1,
                            child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "or sign up with",
                              style: GoogleFonts.poppins(fontSize: 12),
                            ),
                          ),
                          const SizedBox(
                            width: 64,
                            height: 1,
                            child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/google.png', height: 30),
                          const SizedBox(width: 20),
                          Image.asset('assets/facebook.png', height: 30),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: GoogleFonts.poppins(fontSize: 12),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              "Sign in",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Color(0xFF3D93C0),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
