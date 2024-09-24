import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulate a 10-second splash screen delay
    Future.delayed(Duration(seconds: 10), () {
      Navigator.pushReplacementNamed(context, '/welcome');
    });

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          // Wrap content in a scrollable view
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.2), // Add spacing to center content
              Image.asset(
                'assets/images/dsa-logo.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 40),
              //CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
