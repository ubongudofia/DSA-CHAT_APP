import 'package:flutter/material.dart';
import './mockdb.dart';

class ServiceNumberScreen extends StatefulWidget {
  const ServiceNumberScreen({Key? key}) : super(key: key);

  @override
  _ServiceNumberScreenState createState() => _ServiceNumberScreenState();
}

class _ServiceNumberScreenState extends State<ServiceNumberScreen> {
  final TextEditingController _serviceNumberController =
      TextEditingController();

  void _checkUser() {
    String serviceNumber = _serviceNumberController.text.trim();

    // Check if the input is a valid service number
    if (serviceNumber.isEmpty) {
      _showEmptyServiceNumberDialog(); // Show error if empty
    } else {
      // Add the DSA/CIV/ prefix if it is not provided
      if (!serviceNumber.startsWith('DSA/CIV/')) {
        serviceNumber = 'DSA/CIV/$serviceNumber';
      }

      final user = MockDatabase.findUserByServiceNumber(serviceNumber);

      if (user != null && user.isNotEmpty) {
        // User exists, navigate to the Name screen
        Navigator.pushNamed(context, '/name', arguments: user);
      } else {
        _showUserNotFoundDialog(); // Show a popup if the user doesn't exist
      }
    }
  }

  void _showUserNotFoundDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('User Not Found'),
          content:
              const Text('No user found with the provided service number.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showEmptyServiceNumberDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please enter your service number.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Backward arrow icon
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous page
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 150, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 'Official Service Number' text
              const Text(
                'Official Service Number',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Input field with visible outline
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _serviceNumberController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Enter your service number',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 335), // Pushes the button to the bottom

              // Circular submit button with blue background and white arrow
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: _checkUser,
                  backgroundColor: const Color.fromARGB(255, 14, 95, 133),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white, // White arrow icon
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
