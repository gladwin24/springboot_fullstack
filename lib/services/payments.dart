import 'package:flutter/material.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({Key? key}) : super(key: key);

  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedPaymentMethod;

  // List of payment methods
  final List<String> paymentMethods = [
    'Credit Card',
    'Debit Card',
    'Net Banking',
    'UPI',
    'Wallet',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amount Field
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  hintText: 'Enter the amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Payment Method Dropdown
              DropdownButtonFormField<String>(
                value: _selectedPaymentMethod,
                decoration: const InputDecoration(
                  labelText: 'Payment Method',
                  border: OutlineInputBorder(),
                ),
                items: paymentMethods.map((String method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a payment method';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter a description (optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              // Submit Button
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
                  'Make Payment',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
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
          title: const Text('Confirm Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Amount: \$${_amountController.text}'),
              Text('Payment Method: $_selectedPaymentMethod'),
              if (_descriptionController.text.isNotEmpty)
                Text('Description: ${_descriptionController.text}'),
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
                // Process the payment (you can add backend logic here)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Payment processed successfully!'),
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