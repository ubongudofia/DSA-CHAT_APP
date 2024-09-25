import 'package:flutter/material.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

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
              // 'Phone Number' text
              const Text(
                'Phone Number',
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
                      offset: const Offset(0, 3), // Shadow position
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: TextEditingController(text: user['phone_number']),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Phone Number',
                  ),
                  readOnly: true,
                ),
              ),
              const SizedBox(height: 400), // Pushes the button to the bottom

              // Circular submit button with blue background and white arrow
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    // Simulate sending OTP and navigate to the OTP screen
                    Navigator.pushNamed(context, '/otp', arguments: user);
                  },
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
