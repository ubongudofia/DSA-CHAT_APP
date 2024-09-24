import 'package:flutter/material.dart';
import './mockdb.dart';

class ServiceNumberScreen extends StatefulWidget {
  @override
  _ServiceNumberScreenState createState() => _ServiceNumberScreenState();
}

class _ServiceNumberScreenState extends State<ServiceNumberScreen> {
  final TextEditingController _serviceNumberController =
      TextEditingController();

  void _checkUser() {
    final serviceNumber = _serviceNumberController.text.trim();

    if (serviceNumber.isEmpty) {
      // Show error if service number input is empty
      _showEmptyServiceNumberDialog();
    } else {
      final user = MockDatabase.findUserByServiceNumber(serviceNumber);

      if (user != null) {
        // User exists, navigate to the Name screen
        Navigator.pushNamed(context, '/name', arguments: user);
      } else {
        // Show a popup message if the user does not exist
        _showUserNotFoundDialog();
      }
    }
  }

  void _showUserNotFoundDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('User Not Found'),
          content: Text('No user found with the provided service number.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
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
          title: Text('Invalid Input'),
          content: Text('Please enter your service number.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
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
            icon: Icon(Icons.arrow_back), // Backward arrow icon
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
              Text(
                'Official Service Number',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

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
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _serviceNumberController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Enter your service number',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 335), // Pushes the button to the bottom

              // Circular submit button with blue background and white arrow
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: _checkUser,
                  backgroundColor: const Color.fromARGB(255, 14, 95, 133),
                  child: Icon(
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
