// lib/screens/password_setup_screen.dart
import 'package:flutter/material.dart';

class PasswordSetupScreen extends StatefulWidget {
  @override
  _PasswordSetupScreenState createState() => _PasswordSetupScreenState();
}

class _PasswordSetupScreenState extends State<PasswordSetupScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController =
      TextEditingController();

  void _signIn() {
    final password = _passwordController.text;
    final retypePassword = _retypePasswordController.text;

    if (password.isEmpty || retypePassword.isEmpty) {
      _showErrorDialog('Fields cannot be empty');
      return;
    }

    if (password != retypePassword) {
      _showErrorDialog('Passwords do not match');
      return;
    }

    // Proceed to the next step after successful password setup (e.g., navigating to home)
    Navigator.pushReplacementNamed(
        context, '/home'); // Or whatever route you want to navigate to
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Name input
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(16),
                ),
                controller: TextEditingController(text: user['name']),
                readOnly: true,
              ),
              SizedBox(height: 20),

              // Password input
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              SizedBox(height: 20),

              // Re-type Password input
              TextField(
                controller: _retypePasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Re-type Password',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              SizedBox(height: 30),

              // Full-width Sign In button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _signIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 14, 95, 133), // Background color
                    padding: EdgeInsets.symmetric(vertical: 24),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
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
