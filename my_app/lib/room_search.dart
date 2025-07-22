import 'package:flutter/material.dart';
import 'room_details.dart';
import 'home.dart'; 
import 'profile_screen.dart'; 

class RoomListPage extends StatelessWidget {
  RoomListPage({super.key});

  final List<Map<String, dynamic>> rooms = [
    {
      'room_id': 1,
      'title': 'Luxe Lounge',
      'guests': '3 Guests',
      'price': '₱4500/night',
      'freeCancel': 'Free cancellation',
      'imageUrl': 'assets/images/room1.png',
    },
    {
      'room_id': 2,
      'title': 'Deluxe Suite',
      'guests': '3 Guests',
      'price': '₱5200/night',
      'freeCancel': 'Free cancellation',
      'imageUrl': 'assets/images/room2.png',
    },
    {
      'room_id': 3,
      'title': 'Premium King',
      'guests': '3 Guests',
      'price': '₱6000/night',
      'freeCancel': 'Free cancellation',
      'imageUrl': 'assets/images/room3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        title: const Text(
          'Rooms',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    room['imageUrl'] ?? '',
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (i) =>
                              Icon(Icons.star, size: 16, color: Colors.orange),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        room['title'] ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(room['guests'] ?? ''),
                      SizedBox(height: 4),
                      Text(
                        room['price'] ?? '',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        room['freeCancel'] ?? '',
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RoomDetailsPage(
                                  name: room['title'] ?? '',
                                  image: room['imageUrl'] ?? 'assets/images/default.png',
                                  price: int.tryParse(room['price']?.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0,
                                  rating: 4.9,
                                  roomId: room['room_id'] ?? 0,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('View Details'),
                              Icon(Icons.arrow_forward_ios, size: 14),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) async {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HotelHomePage(),
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}
