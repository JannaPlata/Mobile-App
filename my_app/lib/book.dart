import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calendar_page.dart';
import 'alert_message.dart';
import 'room_search.dart'; // ✅ make sure this file contains `RoomListPage`
import 'room_details.dart'; // Still used for "DETAILS" navigation

class RoomDesignPage extends StatefulWidget {
  const RoomDesignPage({super.key});

  @override
  State<RoomDesignPage> createState() => _RoomDesignPageState();
}

class _RoomDesignPageState extends State<RoomDesignPage> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;

  int roomCount = 1;
  int adultCount = 0;
  int childCount = 0;
  bool showRoomOptions = false;

  void showBookingAlert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
        return const AlertMessage();
      },
    );
  }

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
            child: Image.asset('assets/RoomD.png', fit: BoxFit.cover),
          ),

          // ✅ Back arrow goes to RoomListPage (room_search.dart)
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoomListPage(),
                  ),
                );
              },
            ),
          ),

          // ✅ White rounded container
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
                      'Deluxe Suite Room',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Price and Rate
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 161, 161, 161),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text('₱450',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 52, 201, 228),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text('/night',
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
                          const Text(
                            'Rate',
                            style: TextStyle(color: Color.fromARGB(255, 161, 161, 161)),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: const [
                              Text('4.5 ',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              Icon(Icons.star_half, color: Colors.orange, size: 16),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ✅ DETAILS / BOOK NOW section
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DeluxeSuiteRoomPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'DETAILS',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(width: 100),
                            const Text(
                              'BOOK NOW',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(child: Container(height: 2, color: Colors.black26)),
                            Expanded(child: Container(height: 2, color: Colors.lightBlueAccent)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ✅ Calendar Selector
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Check In', style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54)),
                          Text('Check Out', style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CalendarPage()),
                          );
                          if (result != null &&
                              result['checkIn'] != null &&
                              result['checkOut'] != null) {
                            setState(() {
                              _checkInDate = result['checkIn'];
                              _checkOutDate = result['checkOut'];
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _checkInDate != null
                                    ? '${_checkInDate!.month}/${_checkInDate!.day}/${_checkInDate!.year}'
                                    : 'Select',
                                style: GoogleFonts.outfit(fontSize: 12),
                              ),
                              const Icon(Icons.arrow_forward, size: 18, color: Colors.grey),
                              Text(
                                _checkOutDate != null
                                    ? '${_checkOutDate!.month}/${_checkOutDate!.day}/${_checkOutDate!.year}'
                                    : 'Select',
                                style: GoogleFonts.outfit(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // ✅ Room + Guest Selection
                  const Text("Room"),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () {
                      setState(() => showRoomOptions = !showRoomOptions);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$roomCount Room, $adultCount Adult, $childCount Child'),
                          const Icon(Icons.add, size: 18),
                        ],
                      ),
                    ),
                  ),
                  if (showRoomOptions)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            buildCounterRow("Rooms", roomCount, (val) {
                              setState(() {
                                roomCount = val;
                                adultCount = 0;
                                childCount = 0;
                              });
                            }),
                            buildCounterRow("Adults", adultCount, (val) {
                              if (val <= roomCount * 4) {
                                setState(() => adultCount = val);
                              }
                            }),
                            buildCounterRow("Children", childCount, (val) {
                              if (val <= roomCount * 2) {
                                setState(() => childCount = val);
                              }
                            }),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 40),

                  ElevatedButton(
                    onPressed: showBookingAlert,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Center(
                      child: Text(
                        'Complete Booking',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper
  Widget buildCounterRow(String label, int value, Function(int) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: value > 0 ? () => onChanged(value - 1) : null,
            ),
            Text('$value'),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => onChanged(value + 1),
            ),
          ],
        ),
      ],
    );
  }
}
