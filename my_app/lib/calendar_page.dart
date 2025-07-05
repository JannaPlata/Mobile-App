import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime _focusedDay = DateTime.now();
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;

  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Check-In & Check-Out'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              rangeSelectionMode: _rangeSelectionMode,
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_rangeStart, selectedDay)) {
                  setState(() {
                    _rangeStart = selectedDay;
                    _rangeEnd = null;
                    _focusedDay = focusedDay;
                    _rangeSelectionMode = RangeSelectionMode.toggledOn;
                  });
                }
              },
              onRangeSelected: (start, end, focusedDay) {
                setState(() {
                  _rangeStart = start;
                  _rangeEnd = end;
                  _focusedDay = focusedDay;
                  _rangeSelectionMode = RangeSelectionMode.toggledOn;
                });
              },
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
              },
              calendarStyle: const CalendarStyle(
                rangeHighlightColor: Colors.lightBlueAccent,
                todayDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                rangeStartDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                rangeEndDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_rangeStart != null && _rangeEnd != null)
              Column(
                children: [
                  Text(
                    "Check-In: ${_rangeStart!.toLocal().toString().split(' ')[0]}",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Check-Out: ${_rangeEnd!.toLocal().toString().split(' ')[0]}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )
            else if (_rangeStart != null)
              Text(
                "Select check-out date after ${_rangeStart!.toLocal().toString().split(' ')[0]}",
                style: TextStyle(fontSize: 16),
              ),

            const SizedBox(height: 24), // moved button a bit upward

            ElevatedButton(
              onPressed: () {
                if (_rangeStart != null && _rangeEnd != null) {
                  Navigator.pop(context, {
                    'checkIn': _rangeStart,
                    'checkOut': _rangeEnd,
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Confirm Dates',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
