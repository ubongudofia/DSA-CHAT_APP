import 'package:flutter/material.dart';

class EmailScreen extends StatefulWidget {
  final Map<String, String> user;

  EmailScreen({required this.user});

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailOtpController = TextEditingController();
  bool emailOtpSent = false;

  void sendEmailOTP() {
    // Simulate sending OTP to email
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('OTP sent to ${widget.user['email']}')),
    );
    setState(() {
      emailOtpSent = true;
    });
  }

  void submitEmailOTP() {
    String enteredEmailOTP = _emailOtpController.text;

    if (enteredEmailOTP == '123456') {
      // Simulate correct OTP
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Completed!')),
      );
      // Navigate to completion or home page here
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid Email OTP. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Email Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display email
            TextField(
              controller: TextEditingController(text: widget.user['email']),
              decoration: InputDecoration(labelText: 'Email'),
              readOnly: true,
            ),
            SizedBox(height: 20),
            // OTP Input
            if (emailOtpSent)
              TextField(
                controller: _emailOtpController,
                decoration: InputDecoration(labelText: 'Enter Email OTP'),
              ),
            SizedBox(height: 20),
            // Send OTP button or submit OTP button based on state
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: emailOtpSent ? submitEmailOTP : sendEmailOTP,
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
