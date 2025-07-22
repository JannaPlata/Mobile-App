import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle('Effective Date:'),
              sectionContent('[Insert Date]'),

              sectionTitle('1. Information Collection and Use'),
              sectionContent(
                  'We collect personal data only when necessary, such as:\n'
                  '- Full name, email, and contact number during registration or booking.\n'
                  '- Device and usage data to improve performance and security.\n\n'
                  'We do not sell or share your personal information with third parties, '
                  'except when required by law or with your explicit consent.'),

              sectionTitle('2. Data Privacy'),
              sectionContent(
                  '- Your data is stored securely in our protected servers.\n'
                  '- Only authorized personnel have access to your information.\n'
                  '- We comply with applicable data protection laws (e.g., the Philippines Data Privacy Act of 2012).'),

              sectionTitle('3. Data Security'),
              sectionContent(
                  '- We implement industry-standard encryption (e.g., HTTPS, secure login) to protect your data during transmission.\n'
                  '- Passwords are stored using secure hashing techniques.\n'
                  '- We regularly monitor and update our systems to prevent unauthorized access or data breaches.'),

              sectionTitle('4. User Responsibility'),
              sectionContent(
                  'You are responsible for:\n'
                  '- Keeping your account credentials confidential.\n'
                  '- Promptly reporting any suspicious activity or unauthorized access.'),

              sectionTitle('5. Google and Third-Party Logins'),
              sectionContent(
                  'If you sign in using a Google account, we only access necessary data (name and email) to identify your profile securely. '
                  'No additional permissions are used or stored without your approval.'),

              sectionTitle('6. Updates to Our Policy'),
              sectionContent(
                  'We may update this privacy-focused section of our Terms and Conditions from time to time. '
                  'Significant changes will be notified via email or in-app notification.'),

              SizedBox(height: 30),
              Center(
                child: Text(
                  'By continuing to use our services, you agree to these terms.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 6.0),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget sectionContent(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
        height: 1.5,
      ),
    );
  }
}
