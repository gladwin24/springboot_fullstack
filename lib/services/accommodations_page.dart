import 'package:flutter/material.dart';

class AccommodationsPage extends StatefulWidget {
  const AccommodationsPage({super.key});

  @override
  _AccommodationsPageState createState() => _AccommodationsPageState();
}

class _AccommodationsPageState extends State<AccommodationsPage> {
  // Sample list of available rooms
  final List<Map<String, dynamic>> rooms = [
    {
      'type': 'Single Room',
      'capacity': '1 person',
      'price': '\$50 per night',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'type': 'Double Room',
      'capacity': '2 persons',
      'price': '\$80 per night',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'type': 'Suite',
      'capacity': '4 persons',
      'price': '\$120 per night',
      'image': 'https://via.placeholder.com/150',
    },
  ];

  // Selected room for booking
  Map<String, dynamic>? selectedRoom;

  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _checkInController = TextEditingController();
  final _checkOutController = TextEditingController();
  final _guestNameController = TextEditingController();
  final _guestEmailController = TextEditingController();
  final _guestPhoneController = TextEditingController();

  @override
  void dispose() {
    _checkInController.dispose();
    _checkOutController.dispose();
    _guestNameController.dispose();
    _guestEmailController.dispose();
    _guestPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Accommodation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // List of Available Rooms
            const Text(
              'Available Rooms:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: Image.network(
                        rooms[index]['image'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(rooms[index]['type']),
                      subtitle: Text(
                        '${rooms[index]['capacity']} - ${rooms[index]['price']}',
                      ),
                      onTap: () {
                        setState(() {
                          selectedRoom = rooms[index];
                        });
                      },
                      tileColor: selectedRoom == rooms[index]
                          ? Colors.blue.shade50
                          : null,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Room Booking Form
            if (selectedRoom != null) ...[
              Text(
                'Book ${selectedRoom!['type']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _checkInController,
                      decoration: const InputDecoration(
                        labelText: 'Check-In Date',
                        hintText: 'Select check-in date',
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
                            _checkInController.text =
                                "${pickedDate.toLocal()}".split(' ')[0];
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a check-in date';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _checkOutController,
                      decoration: const InputDecoration(
                        labelText: 'Check-Out Date',
                        hintText: 'Select check-out date',
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
                            _checkOutController.text =
                                "${pickedDate.toLocal()}".split(' ')[0];
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a check-out date';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _guestNameController,
                      decoration: const InputDecoration(
                        labelText: 'Guest Name',
                        hintText: 'Enter your name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _guestEmailController,
                      decoration: const InputDecoration(
                        labelText: 'Guest Email',
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _guestPhoneController,
                      decoration: const InputDecoration(
                        labelText: 'Guest Phone',
                        hintText: 'Enter your phone number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Show confirmation dialog
                          _showConfirmationDialog(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        'Book Room',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
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
              Text('Room: ${selectedRoom!['type']}'),
              Text('Check-In: ${_checkInController.text}'),
              Text('Check-Out: ${_checkOutController.text}'),
              Text('Guest Name: ${_guestNameController.text}'),
              Text('Guest Email: ${_guestEmailController.text}'),
              Text('Guest Phone: ${_guestPhoneController.text}'),
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
                    content: Text('Room booked successfully!'),
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