import 'package:flutter/material.dart';

class CanteenPage extends StatefulWidget {
  const CanteenPage({Key? key}) : super(key: key); // Added key parameter

  @override
  _CanteenPageState createState() => _CanteenPageState();
}

class _CanteenPageState extends State<CanteenPage> {
  // Sample list of available food items
  final List<Map<String, dynamic>> foodItems = [
    {
      'name': 'Burger',
      'description': 'Delicious beef burger with cheese and veggies',
      'price': '\$5.00',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Pizza',
      'description': 'Classic margherita pizza with fresh mozzarella',
      'price': '\$8.00',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Pasta',
      'description': 'Creamy Alfredo pasta with grilled chicken',
      'price': '\$7.00',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Salad',
      'description': 'Fresh garden salad with a variety of vegetables',
      'price': '\$4.00',
      'image': 'https://via.placeholder.com/150',
    },
  ];

  // Selected food items and their quantities
  final Map<String, int> selectedItems = {};

  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _specialInstructionsController = TextEditingController();

  @override
  void dispose() {
    _specialInstructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Canteen Food Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // List of Available Food Items
            const Text(
              'Available Food Items:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: foodItems.length,
                itemBuilder: (context, index) {
                  final item = foodItems[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: Image.network(
                        item['image'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item['name']),
                      subtitle: Text(
                        '${item['description']} - ${item['price']}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (selectedItems.containsKey(item['name']) &&
                                    selectedItems[item['name']]! > 0) {
                                  selectedItems[item['name']] =
                                      selectedItems[item['name']]! - 1;
                                }
                              });
                            },
                          ),
                          Text(
                            selectedItems.containsKey(item['name'])
                                ? selectedItems[item['name']].toString()
                                : '0',
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                if (selectedItems.containsKey(item['name'])) {
                                  selectedItems[item['name']] =
                                      selectedItems[item['name']]! + 1;
                                } else {
                                  selectedItems[item['name']] = 1;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Food Booking Form
            const Text(
              'Special Instructions:',
              style: TextStyle(
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
                    controller: _specialInstructionsController,
                    decoration: const InputDecoration(
                      labelText: 'Instructions',
                      hintText: 'Enter any special instructions',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_validateSelection()) {
                        // Show confirmation dialog
                        _showConfirmationDialog(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select at least one item.'),
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
                      'Place Order',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Validate if at least one item is selected
  bool _validateSelection() {
    return selectedItems.values.any((quantity) => quantity > 0);
  }

  // Show confirmation dialog
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Order'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Selected Items:'),
              ...selectedItems.entries.map((entry) {
                if (entry.value > 0) {
                  return Text('${entry.key} x ${entry.value}');
                }
                return const SizedBox.shrink();
              }),
              const SizedBox(height: 10),
              Text(
                  'Special Instructions: ${_specialInstructionsController.text}'),
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
                // Save the order (you can add backend logic here)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Order placed successfully!'),
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