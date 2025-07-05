import 'package:flutter/material.dart';
import 'room_details.dart';
import 'room_search.dart';
import 'profile_screen.dart'; // ✅ Added this import

class HotelHomePage extends StatelessWidget {
  final String username;

  const HotelHomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header image with booking details
            Stack(
              children: [
                Image.asset(
                  'assets/background.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 10,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: const [
                            Text("Check In", style: TextStyle(fontSize: 10)),
                            Text(
                              "March 16, 2025",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        Column(
                          children: const [
                            Text("Check Out", style: TextStyle(fontSize: 10)),
                            Text(
                              "March 18, 2025",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        Column(
                          children: const [
                            Text("Guest", style: TextStyle(fontSize: 10)),
                            Text("2", style: TextStyle(fontSize: 10)),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RoomListPage(),
                              ),
                            );
                          },
                          child: const Text("Book Now"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search Here...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            // Rooms Section
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: sectionTitle(context, "Rooms"),
            ),
            roomList(context),

            // Events Section
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: sectionTitle(context, "Events"),
            ),
            eventList(),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Home selected
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RoomListPage()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(username: "Guest"),
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

  Widget sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (title == "Rooms") // ✅ Only show arrow for Rooms
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RoomListPage()),
                );
              },
              child: const Icon(Icons.arrow_forward),
            ),
        ],
      ),
    );
  }

  Widget roomList(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DeluxeSuiteRoomPage(),
              ),
            );
          },
          child: Container(
            width: 160,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.asset(
                      'assets/room${index + 1}.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Luxxe Lounge\n₱4,550",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget eventList() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          eventCard('assets/offer1.png'),
          const SizedBox(width: 10),
          eventCard('assets/offer2.png'),
          const SizedBox(width: 10),
          eventCard('assets/offer3.png'),
          const SizedBox(width: 10),
          eventCard('assets/offer1.png'),
        ],
      ),
    );
  }

  Widget eventCard(String imgUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(imgUrl, width: 200, fit: BoxFit.cover),
    );
  }
}
