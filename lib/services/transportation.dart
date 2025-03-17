import 'package:flutter/material.dart';

class TransportationPage extends StatefulWidget {
  const TransportationPage({Key? key}) : super(key: key);

  @override
  _TransportationPageState createState() => _TransportationPageState();
}

class _TransportationPageState extends State<TransportationPage> {
  // Sample list of available transportation options
  final List<Map<String, dynamic>> transportationOptions = [
    {
      'type': 'Bus',
      'capacity': '50 passengers',
      'schedule': 'Mon-Fri, 8:00 AM - 6:00 PM',
    },
    {
      'type': 'Shuttle',
      'capacity': '20 passengers',
      'schedule': 'Mon-Fri, 9:00 AM - 5:00 PM',
    },
    {
      'type': 'Van',
      'capacity': '10 passengers',
      'schedule': 'Mon-Fri, 10:00 AM - 4:00 PM',
    },
  ];

  // Selected transportation option and booking details
  Map<String, dynamic>? selectedTransportation;
  final _dateController = TextEditingController();
  final _passengerNameController = TextEditingController();
  final _passengerPhoneController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _passengerNameController.dispose();
    _passengerPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transportation Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // List of Available Transportation Options
            Text(
              'Available Transportation:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: transportationOptions.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(transportationOptions[index]['type']),
                      subtitle: Text(
                        'Capacity: ${transportationOptions[index]['capacity']} - Schedule: ${transportationOptions[index]['schedule']}',
                      ),
                      onTap: () {
                        setState(() {
                          selectedTransportation = transportationOptions[index];
                        });
                      },
                      tileColor: selectedTransportation == transportationOptions[index]
                          ? Colors.blue.shade50
                          : null,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            // Transportation Booking Form
            if (selectedTransportation != null) ...[
              Text(
                'Book ${selectedTransportation!['type']}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
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
                    });
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passengerNameController,
                decoration: InputDecoration(
                  labelText: 'Passenger Name',
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passengerPhoneController,
                decoration: InputDecoration(
                  labelText: 'Passenger Phone',
                  hintText: 'Enter your phone number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_dateController.text.isNotEmpty &&
                      _passengerNameController.text.isNotEmpty &&
                      _passengerPhoneController.text.isNotEmpty) {
                    // Show confirmation dialog
                    _showConfirmationDialog(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill all fields.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  'Book Transportation',
                  style: TextStyle(fontSize: 16, color: Colors.white),
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
          title: Text('Booking Confirmed'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Transportation: ${selectedTransportation!['type']}'),
              Text('Date: ${_dateController.text}'),
              Text('Passenger Name: ${_passengerNameController.text}'),
              Text('Passenger Phone: ${_passengerPhoneController.text}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Save the booking (you can add backend logic here)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Transportation booked successfully!'),
                    duration: Duration(seconds: 2),
                  ),
                );
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}