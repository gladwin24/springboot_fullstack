import 'package:flutter/material.dart';

class HallBookingPage extends StatefulWidget {
  const HallBookingPage({Key? key}) : super(key: key);

  @override
  _HallBookingPageState createState() => _HallBookingPageState();
}

class _HallBookingPageState extends State<HallBookingPage> {
  // Sample list of available halls
  final List<Map<String, dynamic>> halls = [
    {
      'name': 'Main Hall',
      'capacity': '500 people',
      'timeSlots': [
        {'date': '2023-10-25', 'slots': ['10:00 AM - 12:00 PM', '2:00 PM - 4:00 PM']},
        {'date': '2023-10-26', 'slots': ['9:00 AM - 11:00 AM', '1:00 PM - 3:00 PM']},
      ],
    },
    {
      'name': 'Conference Room',
      'capacity': '100 people',
      'timeSlots': [
        {'date': '2023-10-25', 'slots': ['11:00 AM - 1:00 PM']},
        {'date': '2023-10-26', 'slots': ['10:00 AM - 12:00 PM', '3:00 PM - 5:00 PM']},
      ],
    },
    {
      'name': 'Auditorium',
      'capacity': '300 people',
      'timeSlots': [
        {'date': '2023-10-25', 'slots': ['9:00 AM - 11:00 AM', '4:00 PM - 6:00 PM']},
        {'date': '2023-10-26', 'slots': ['2:00 PM - 4:00 PM']},
      ],
    },
  ];

  // Selected hall, date, and time slot
  Map<String, dynamic>? selectedHall;
  String? selectedDate;
  String? selectedTimeSlot;

  // Form controllers
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hall Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // List of Available Halls
            const Text(
              'Available Halls:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: halls.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(halls[index]['name']),
                      subtitle: Text('Capacity: ${halls[index]['capacity']}'),
                      onTap: () {
                        setState(() {
                          selectedHall = halls[index];
                          selectedDate = null;
                          selectedTimeSlot = null;
                        });
                      },
                      tileColor: selectedHall == halls[index]
                          ? Colors.blue.shade50
                          : null,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Hall Booking Form
            if (selectedHall != null) ...[
              Text(
                'Book ${selectedHall!['name']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  hintText: 'Select a date',
                  suffixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dateController.text =
                          "${pickedDate.toLocal()}".split(' ')[0];
                      selectedDate = _dateController.text;
                      selectedTimeSlot = null;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              if (selectedDate != null) ...[
                const Text(
                  'Available Time Slots:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: selectedHall!['timeSlots']
                      .where((slot) => slot['date'] == selectedDate)
                      .map((slot) {
                    return Column(
                      children: slot['slots'].map<Widget>((timeSlot) {
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(timeSlot),
                            onTap: () {
                              setState(() {
                                selectedTimeSlot = timeSlot;
                              });
                            },
                            tileColor: selectedTimeSlot == timeSlot
                                ? Colors.blue.shade50
                                : null,
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 20),
              if (selectedTimeSlot != null) ...[
                ElevatedButton(
                  onPressed: () {
                    // Show confirmation dialog
                    _showConfirmationDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Book Hall',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  // Show confirmation dialog
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Booking'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hall: ${selectedHall!['name']}'),
              Text('Date: $selectedDate'),
              Text('Time Slot: $selectedTimeSlot'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save the booking (you can add backend logic here)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Hall booked successfully!'),
                    duration: Duration(seconds: 2),
                  ),
                );
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}