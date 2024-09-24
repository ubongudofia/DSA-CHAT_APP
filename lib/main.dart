import 'package:flutter/material.dart';
import 'package:dsa_messaging_app/splash/pages/splash_page.dart';

import 'auth/servicenumber.dart';
import 'auth/name.dart';
import 'auth/phonenumber.dart';
import 'auth/otpscreen.dart';
import 'auth/email.dart';
import 'auth/emailotp.dart';
import 'auth/password.dart';
import 'login/loginpage.dart';
import 'login/forgot_password.dart';

import 'welcome.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DSA Messaging App',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/service_number': (context) => ServiceNumberScreen(),
        '/name': (context) => NameScreen(),
        '/phone': (context) => PhoneNumberScreen(),
        '/otp': (context) => PhoneOtpScreen(),
        '/email': (context) => EmailScreen(),
        '/email_otp': (context) => EmailOtpScreen(),
        '/password_setup': (context) => PasswordSetupScreen(),
        '/login_page': (context) => LoginPage(),
        '/forgot_password': (context) =>
            ForgotPasswordScreen(), // Add the new route
      },
    );
  }
}
