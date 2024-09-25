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
import 'nav_screens/contact_screen.dart';
import 'nav_screens/chat_screen.dart';

import 'welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        '/contact': (context) => ContactScreen(),
        '/login_page': (context) => LoginPage(),
        '/chat_screen': (context) => ChatScreen(),
        '/forgot_password': (context) =>
            ForgotPasswordScreen(), // Add the new route
      },
    );
  }
}
