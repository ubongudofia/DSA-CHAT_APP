import 'package:flutter/material.dart';
import 'dart:async'; // For the countdown timer

class EmailOtpScreen extends StatefulWidget {
  @override
  _EmailOtpScreenState createState() => _EmailOtpScreenState();
}

class _EmailOtpScreenState extends State<EmailOtpScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  Timer? _timer;
  int _secondsRemaining = 30; // Set the countdown timer for 30 seconds
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the timer when the screen is loaded
  }

  void _startTimer() {
    _secondsRemaining = 30;
    _canResend = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _canResend = true; // Enable the resend button when timer ends
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Dispose the timer when the screen is destroyed
    super.dispose();
  }

  void _submitOtp() {
    final otp = _otpControllers.map((controller) => controller.text).join();

    if (otp.length == 6) {
      // Simulate OTP validation
      final user =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;

      // Navigate to Password Setup Screen with user info
      Navigator.pushReplacementNamed(context, '/password_setup',
          arguments: user);
    } else {
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Invalid OTP'),
          content: Text('Please enter the complete 6-digit OTP.'),
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

  void _resendOtp() {
    setState(() {
      _startTimer(); // Restart the timer
    });

    // Here you would normally trigger the OTP resend logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('OTP has been resent to your email!')),
    );
  }

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
            icon: Icon(Icons.arrow_back), // Backward arrow icon
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous page
            },
          ),
          //title: Text('Enter Email OTP', style: TextStyle(color: Colors.black)),
          elevation: 0, // To match the flat AppBar design
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 150, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display email information
              Text(
                'Enter the OTP sent to ${user['email']}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return Container(
                    width: 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _otpControllers[index],
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),

              // Resend OTP timer and button
              if (!_canResend) Text('Resend OTP in $_secondsRemaining seconds'),
              if (_canResend)
                TextButton(
                  onPressed: _resendOtp,
                  child: Text('Resend OTP'),
                ),
              SizedBox(height: 375),

              // Floating Action Button
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: _submitOtp,
                  backgroundColor: const Color.fromARGB(255, 14, 95, 133),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
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
