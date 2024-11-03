import 'package:flutter/material.dart';
import 'auth/mockdb.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // padding: EdgeInsets.only(top: 150.0),
                child: Image.asset(
                  'assets/images/dhq_logo.png',
                  width: 200,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                // padding: EdgeInsets.only(top: 150.0),
                child: Image.asset(
                  'assets/images/afncom.png',
                  width: 100,
                ),
              ),
              const SizedBox(height: 15),
              const Center(
                child: SizedBox(
                  width: 350,
                  child: Text(
                    'Armed Forces of Nigeria Messaging App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/service_number');
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        WidgetStateProperty.all<Color>(const Color(0xFF0D6EFF)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                  child: TextButton(
                onPressed: () {
                  final user = MockDatabase.findUserByServiceNumber(
                      '123456'); // Fetch user
                  if (user != null) {
                    // Check if any of the fields might be null, and handle it
                    final userName =
                        user['name'] ?? 'Unknown'; // Provide a fallback value
                    Navigator.pushNamed(
                      context,
                      '/login_page',
                      arguments: {
                        'name': userName
                      }, // Ensure 'name' is non-null
                    );
                  } else {
                    // Handle case where no user is found, perhaps show an error
                  }
                },
                child: const Text(
                  'Already a user? Signin',
                  style: TextStyle(
                    //fontWeight: FontWeight.regular,
                    fontSize: 18,
                    // color: Colors.white,
                    // backgroundColor: const Color.fromARGB(255, 14, 95, 133),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
