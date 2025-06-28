import 'package:flutter/material.dart';

// void main() {
//   runApp(const DeluxeSuiteRoomApp(
//   ));
// }

// // Entry widget of the app
// class DeluxeSuiteRoomApp extends StatelessWidget {
//   const DeluxeSuiteRoomApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
// Main screen representing the hotel room details
class DeluxeSuiteRoomPage extends StatelessWidget {
  const DeluxeSuiteRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: Image.asset('assets/images/room4.png', fit: BoxFit.cover),
          ),

          // Bottom content container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              height: MediaQuery.of(context).size.height * 0.65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Room Title
                  const Text(
                    'Deluxe Suite Room',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Price and Rating Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price Info
                      Row(
                        children: const [
                          Text(
                            '₱4500',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '/night',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      // Rating Stars
                      Row(
                        children: const [
                          Text(
                            '4.5',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          Icon(Icons.star_half, color: Colors.orange, size: 16),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Tabs Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      // "Details" Tab
                      Column(
                        children: [
                          Text(
                            'DETAILS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(height: 4),
                          // Blue underline indicator
                          SizedBox(
                            width: 60,
                            height: 2,
                            child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      // "Book Now" Tab
                      Text(
                        'BOOK NOW',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Details Description
                  const Text(
                    'Details',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Experience comfort and luxury in our spacious Deluxe Suite, perfect for couples or small families. This elegant room features a plush king bed, a cozy seating area, modern interiors, and large windows with scenic views.',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),

                  const SizedBox(height: 24),

                  // Amenities Section
                  const Text(
                    'Amenities',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Amenities Icons and Text
                  Wrap(
                    spacing: 24,
                    runSpacing: 16,
                    children: const [
                      Amenity(icon: Icons.tv, label: 'Flat-screen TV'),
                      Amenity(icon: Icons.ac_unit, label: 'Air-conditioner'),
                      Amenity(icon: Icons.wifi, label: 'Free Wi-Fi'),
                      Amenity(
                        icon: Icons.soap,
                        label: 'Fresh Towels\n& Toiletries',
                      ),
                      Amenity(
                        icon: Icons.room_service,
                        label: 'Room Services Available',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable widget for each amenity item
class Amenity extends StatelessWidget {
  final IconData icon;
  final String label;

  const Amenity({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 28, color: Colors.black54),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
      ],
    );
  }
}
