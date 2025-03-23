import 'package:flutter/material.dart';

class TicketBookingPage extends StatefulWidget {
  const TicketBookingPage({Key? key}) : super(key: key);

  @override
  _TicketBookingPageState createState() => _TicketBookingPageState();
}

class _TicketBookingPageState extends State<TicketBookingPage> {
  // Sample list of available events
  final List<Map<String, dynamic>> events = [
    {
      'name': 'Annual Conference',
      'date': '2023-11-15',
      'price': '\$50',
    },
    {
      'name': 'Music Festival',
      'date': '2023-12-01',
      'price': '\$30',
    },
    {
      'name': 'Tech Expo',
      'date': '2023-11-20',
      'price': '\$20',
    },
  ];

  // Selected event and ticket details
  Map<String, dynamic>? selectedEvent;
  int numberOfTickets = 1;
  final _attendeeNameController = TextEditingController();
  final _attendeeEmailController = TextEditingController();

  // Generated ticket details
  String? ticketId;
  String? eventName;
  String? eventDate;
  String? attendeeName;

  @override
  void dispose() {
    _attendeeNameController.dispose();
    _attendeeEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // List of Available Events
            const Text(
              'Available Events:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(events[index]['name']),
                      subtitle: Text(
                        'Date: ${events[index]['date']} - Price: ${events[index]['price']}',
                      ),
                      onTap: () {
                        setState(() {
                          selectedEvent = events[index];
                          ticketId = null; // Reset ticket ID when a new event is selected
                        });
                      },
                      tileColor: selectedEvent == events[index]
                          ? Colors.blue.shade50
                          : null,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Ticket Booking Form
            if (selectedEvent != null) ...[
              Text(
                'Book ${selectedEvent!['name']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _attendeeNameController,
                decoration: const InputDecoration(
                  labelText: 'Attendee Name',
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _attendeeEmailController,
                decoration: const InputDecoration(
                  labelText: 'Attendee Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Number of Tickets:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (numberOfTickets > 1) {
                          numberOfTickets--;
                        }
                      });
                    },
                  ),
                  Text(
                    numberOfTickets.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        numberOfTickets++;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_attendeeNameController.text.isNotEmpty &&
                      _attendeeEmailController.text.isNotEmpty) {
                    // Generate a ticket
                    _generateTicket();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all fields.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Book Tickets',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
            const SizedBox(height: 20),
            // Generated Ticket
            if (ticketId != null) ...[
              const Text(
                'Your Ticket:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ticket ID: $ticketId'),
                      Text('Event: $eventName'),
                      Text('Date: $eventDate'),
                      Text('Attendee: $attendeeName'),
                      Text('Number of Tickets: $numberOfTickets'),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Generate a ticket
  void _generateTicket() {
    setState(() {
      ticketId = 'TKT-${DateTime.now().millisecondsSinceEpoch}';
      eventName = selectedEvent!['name'];
      eventDate = selectedEvent!['date'];
      attendeeName = _attendeeNameController.text;
    });

    // Show confirmation dialog
    _showConfirmationDialog(context);
  }

  // Show confirmation dialog
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Booking Confirmed'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ticket ID: $ticketId'),
              Text('Event: $eventName'),
              Text('Date: $eventDate'),
              Text('Attendee: $attendeeName'),
              Text('Number of Tickets: $numberOfTickets'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}