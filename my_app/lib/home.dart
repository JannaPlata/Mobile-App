import 'package:flutter/material.dart';
import 'room_details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HotelHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HotelHomePage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  HotelHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header image with booking details
            Stack(
              children: [
                Image.asset(
                  'assets/images/background.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 10,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Check In", style: TextStyle(fontSize: 10)),
                            Text(
                              "March 16, 2025",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Check Out", style: TextStyle(fontSize: 10)),
                            Text(
                              "March 18, 2025",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Guest", style: TextStyle(fontSize: 10)),
                            Text("2", style: TextStyle(fontSize: 10)),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("Book Now"),
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
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search Here...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            // Rooms Section
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: sectionTitle("Rooms"),
            ),
            roomList(context),

            // Events Section
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: sectionTitle("Events"),
            ),
            eventList(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.arrow_forward),
        ],
      ),
    );
  }

  //support navigation on tap
  Widget roomList(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            //SearchRoom page when a room is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DeluxeSuiteRoomPage(),
              ),
            );
          },
          child: Container(
            width: 160,
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.asset(
                      'assets/images/room${index + 1}.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          eventCard('assets/images/offer1.png'),
          SizedBox(width: 10),
          eventCard('assets/images/offer2.png'),
          SizedBox(width: 10),
          eventCard('assets/images/offer3.png'),
          SizedBox(width: 10),
          eventCard('assets/images/offer1.png'),
        ],
      ),
    );
  }

  Widget eventCard(String imgUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imgUrl,
        width: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}
