import 'package:flutter/material.dart';
import 'room_details.dart';
import 'room_search.dart';
import 'profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HotelHomePage extends StatefulWidget {
  const HotelHomePage({super.key});

  @override
  State<HotelHomePage> createState() => _HotelHomePageState();
}

class _HotelHomePageState extends State<HotelHomePage> {
  String _username = '';
  String _email = '';
  String _phone = '';

  String? _lastCheckIn;
  String? _lastCheckOut;
  int? _lastAdults;
  int? _lastChildren;
  int? _lastRoomCount;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadLastBooking();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
      _email = prefs.getString('email') ?? '';
      _phone = prefs.getString('phone') ?? '';
    });
  }

  Future<void> _loadLastBooking() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastCheckIn = prefs.getString('last_booking_checkin');
      _lastCheckOut = prefs.getString('last_booking_checkout');
      _lastAdults = prefs.getInt('last_booking_adults');
      _lastChildren = prefs.getInt('last_booking_children');
      _lastRoomCount = prefs.getInt('last_booking_room_count');
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadLastBooking();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Header image
            Image.asset(
              'assets/images/background.jpg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            // Booking details section overlays the bottom of the image
            Positioned(
              left: 16,
              right: 16,
              top: 160, // overlaps the bottom of the image
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(16),
                shadowColor: Colors.black26,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text("Check In", style: TextStyle(fontSize: 10)),
                          Text(
                            _lastCheckIn ?? '--',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Check Out", style: TextStyle(fontSize: 10)),
                          Text(
                            _lastCheckOut ?? '--',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Guest", style: TextStyle(fontSize: 10)),
                          Text(
                            (_lastAdults != null || _lastChildren != null)
                                ? '${(_lastAdults ?? 0) + (_lastChildren ?? 0)}'
                                : '--',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RoomListPage(),
                            ),
                          );
                          _loadLastBooking();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        child: const Text("Book Now"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Main content below the booking card
            Padding(
              padding: const EdgeInsets.only(top: 235),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Add more space after booking card
                  const SizedBox(height: 24),
                  // Welcome message just above Rooms section
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Welcome,  $_username!',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Add more space before Rooms section
                  const SizedBox(height: 12),
                  // Rooms Section
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
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
          if (title == "Rooms")
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
    final List<Map<String, dynamic>> rooms = [
      {
        'room_id': 1,
        'name': 'Luxe Lounge',
        'image': 'assets/images/room1.png',
        'price': 4500,
        'rating': 4.9,
      },
      {
        'room_id': 2,
        'name': 'Deluxe Suite',
        'image': 'assets/images/room2.png',
        'price': 5200,
        'rating': 4.7,
      },
      {
        'room_id': 3,
        'name': 'Premium King',
        'image': 'assets/images/room3.png',
        'price': 6000,
        'rating': 4.8,
      },
    ];
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: rooms.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final room = rooms[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomDetailsPage(
                    name: room['name'],
                    image: room['image'],
                    price: room['price'],
                    rating: room['rating'],
                    roomId: room['room_id'],
                  ),
                ),
              );
            },
            child: Container(
              width: 160,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
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
                        room['image'],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            room['name'],
                            style: GoogleFonts.playfairDisplay(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.orange, size: 15),
                            Text(
                              room['rating'].toString(),
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₱',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        Text(
                          '${room['price']}',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '/night',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: Color(0xFFD9D9D9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget eventList() {
    final List<Map<String, String>> events = [
      {'image': 'assets/images/offer1.png', 'name': 'Wedding'},
      {'image': 'assets/images/offer2.png', 'name': 'Birthday'},
      {'image': 'assets/images/offer3.png', 'name': 'Reunion'},
      {'image': 'assets/images/offer1.png', 'name': 'Seminar'},
    ];
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          for (int i = 0; i < events.length; i++) ...[
            eventCard(events[i]['image']!, events[i]['name']!),
            if (i != events.length - 1) const SizedBox(width: 10),
          ]
        ],
      ),
    );
  }

  Widget eventCard(String imgUrl, String name) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(imgUrl, width: 200, height: 100, fit: BoxFit.cover),
        ),
        Positioned(
          left: 12,
          bottom: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}