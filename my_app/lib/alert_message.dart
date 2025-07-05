import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertMessage extends StatelessWidget {
  const AlertMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF58CAFF), // Light blue background
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ✅ Larger, rounded check icon
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded, // Rounded, bolder check icon
                  color: Color(0xFF58CAFF),
                  size: 40, // Larger size for better visibility
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Booking Confirmed!',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Thank you for booking with\nRosario Resorts and Hotel!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
