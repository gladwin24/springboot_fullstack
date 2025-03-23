import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  // Sample list of institution members
  final List<Map<String, dynamic>> members = [
    {
      'name': 'Dr. John Doe',
      'role': 'Professor',
      'availability': 'Mon-Fri, 9 AM - 5 PM',
    },
    {
      'name': 'Ms. Jane Smith',
      'role': 'Administrator',
      'availability': 'Tue-Thu, 10 AM - 4 PM',
    },
    {
      'name': 'Mr. Robert Brown',
      'role': 'Counselor',
      'availability': 'Mon-Wed, 11 AM - 3 PM',
    },
  ];

  // Selected member for appointment
  Map<String, dynamic>? selectedMember;

  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _purposeController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // List of Institution Members
            const Text(
              'Select a Member:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.blue),
                      title: Text(members[index]['name']),
                      subtitle: Text(
                        '${members[index]['role']} - ${members[index]['availability']}',
                      ),
                      onTap: () {
                        setState(() {
                          selectedMember = members[index];
                        });
                      },
                      tileColor: selectedMember == members[index]
                          ? Colors.blue.shade50
                          : null,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Appointment Booking Form
            if (selectedMember != null) ...[
              Text(
                'Book Appointment with ${selectedMember!['name']}',
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
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a date';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _timeController,
                      decoration: const InputDecoration(
                        labelText: 'Time',
                        hintText: 'Select a time',
                        suffixIcon: Icon(Icons.access_time),
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            _timeController.text = pickedTime.format(context);
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a time';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _purposeController,
                      decoration: const InputDecoration(
                        labelText: 'Purpose',
                        hintText: 'Enter the purpose of the appointment',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the purpose';
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
                        'Book Appointment',
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
          title: const Text('Confirm Appointment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Member: ${selectedMember!['name']}'),
              Text('Date: ${_dateController.text}'),
              Text('Time: ${_timeController.text}'),
              Text('Purpose: ${_purposeController.text}'),
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
                // Save the appointment (you can add backend logic here)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Appointment booked successfully!'),
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