// import 'package:flutter/material.dart';
// import 'package:dsa_messaging_app/register.dart';

// class Welcome extends StatefulWidget {
//   const Welcome({Key? key}) : super(key: key);

//   @override
//   _WelcomeState createState() => _WelcomeState();
// }

// class _WelcomeState extends State<Welcome> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Color(0xfff7f6fb),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
//           child: Column(
//             children: [
//               Image.asset(
//                 'assets/images/dsa-logo.png',
//                 width: 240,
//               ),
//               SizedBox(
//                 height: 18,
//               ),
//               Text(
//                 "Let's get started",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "Defence Space Administration most secured app for the Nigerian Military",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black38,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: 38,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => Register()),
//                     );
//                   },
//                   style: ButtonStyle(
//                     foregroundColor:
//                         WidgetStateProperty.all<Color>(Colors.white),
//                     backgroundColor:
//                         WidgetStateProperty.all<Color>(Colors.purple),
//                     shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(24.0),
//                       ),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(14.0),
//                     child: Text(
//                       'Create Account',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 22,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ButtonStyle(
//                     foregroundColor:
//                         WidgetStateProperty.all<Color>(Colors.purple),
//                     backgroundColor:
//                         WidgetStateProperty.all<Color>(Colors.white),
//                     shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(24.0),
//                       ),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(14.0),
//                     child: Text(
//                       'Login',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
