import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'book.dart';

class RoomDetailsPage extends StatelessWidget {
  final String name;
  final String image;
  final int price;
  final double rating;
  final int roomId;

  const RoomDetailsPage({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.roomId,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: screenHeight * 0.4,
            width: double.infinity,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.3),
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 50),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      name,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 161, 161, 161),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                '₱',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 52, 201, 228),
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              Text(
                                '$price',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 52, 201, 228),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '/night',
                                style: GoogleFonts.poppins(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Rate',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 161, 161, 161),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                '${rating.toStringAsFixed(1)} ',
                                style: const TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              Icon(
                                Icons.star_half,
                                color: Colors.orange,
                                size: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'DETAILS',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.lightBlue,
                              ),
                            ),
                            const SizedBox(width: 100),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RoomDesignPage(
                                      name: name,
                                      image: image,
                                      price: price,
                                      rating: rating,
                                      roomId: roomId,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'BOOK NOW',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 2,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 2,
                                color: Colors.black26,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                  Text(
                    'Experience comfort and luxury in our spacious Luxe Lounge, perfect for couples or small families. This elegant room features a plush king bed, a cozy seating area, modern interiors, and large windows with scenic views.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Amenities',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 24,
                    runSpacing: 16,
                    children: const [
                      Amenity(icon: Icons.tv, label: 'Flat-screen TV'),
                      Amenity(icon: Icons.ac_unit, label: 'Air-conditioner'),
                      Amenity(icon: Icons.wifi, label: 'Free Wi-Fi'),
                      Amenity(
                        icon: Icons.soap,
                        label: 'Fresh Towels & Toiletries',
                      ),
                      Amenity(icon: Icons.room_service, label: 'Room Service'),
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
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87),
        ),
      ],
    );
  }
}