import 'package:flutter/material.dart';

import 'phonenumber.dart';

class NameScreen extends StatelessWidget {
  final Map<String, String> user;

  NameScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Name Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the name of the user
            TextField(
              controller: TextEditingController(text: user['name']),
              decoration: InputDecoration(labelText: 'Name'),
              readOnly: true,
            ),
            SizedBox(height: 20),
            // Submit button to move to Phone Number Screen
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhoneNumberScreen(user: user),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(16),
                ),
                child: Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
