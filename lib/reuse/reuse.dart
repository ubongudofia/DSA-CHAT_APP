// // import 'package:flutter/material.dart';
// // import 'package:dsa_messaging_app/register.dart';

// // class Welcome extends StatefulWidget {
// //   const Welcome({Key? key}) : super(key: key);

// //   @override
// //   _WelcomeState createState() => _WelcomeState();
// // }

// // class _WelcomeState extends State<Welcome> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       resizeToAvoidBottomInset: false,
// //       backgroundColor: Color(0xfff7f6fb),
// //       body: SafeArea(
// //         child: Padding(
// //           padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
// //           child: Column(
// //             children: [
// //               Image.asset(
// //                 'assets/images/dsa-logo.png',
// //                 width: 240,
// //               ),
// //               SizedBox(
// //                 height: 18,
// //               ),
// //               Text(
// //                 "Let's get started",
// //                 style: TextStyle(
// //                   fontSize: 22,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 10,
// //               ),
// //               Text(
// //                 "Defence Space Administration most secured app for the Nigerian Military",
// //                 style: TextStyle(
// //                   fontSize: 14,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.black38,
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),
// //               SizedBox(
// //                 height: 38,
// //               ),
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: () {
// //                     Navigator.of(context).push(
// //                       MaterialPageRoute(builder: (context) => Register()),
// //                     );
// //                   },
// //                   style: ButtonStyle(
// //                     foregroundColor:
// //                         WidgetStateProperty.all<Color>(Colors.white),
// //                     backgroundColor:
// //                         WidgetStateProperty.all<Color>(Colors.purple),
// //                     shape: WidgetStateProperty.all<RoundedRectangleBorder>(
// //                       RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(24.0),
// //                       ),
// //                     ),
// //                   ),
// //                   child: Padding(
// //                     padding: EdgeInsets.all(14.0),
// //                     child: Text(
// //                       'Create Account',
// //                       style: TextStyle(fontSize: 16),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 22,
// //               ),
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   onPressed: () {},
// //                   style: ButtonStyle(
// //                     foregroundColor:
// //                         WidgetStateProperty.all<Color>(Colors.purple),
// //                     backgroundColor:
// //                         WidgetStateProperty.all<Color>(Colors.white),
// //                     shape: WidgetStateProperty.all<RoundedRectangleBorder>(
// //                       RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(24.0),
// //                       ),
// //                     ),
// //                   ),
// //                   child: Padding(
// //                     padding: EdgeInsets.all(14.0),
// //                     child: Text(
// //                       'Login',
// //                       style: TextStyle(fontSize: 16),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }





// import 'dart:io';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:path_provider/path_provider.dart'; // Not supported for web
// import 'package:record/record.dart'; // Not supported for web
// import 'package:audioplayers/audioplayers.dart'; // For playing audio on both web and mobile
// import 'package:path/path.dart' as p;
// //import 'package:record/record.dart';

// import './audio_call_screen.dart';
// import './video_call_screen.dart';
// import './contact_info.dart';

// class ChatDetailScreen extends StatefulWidget {
//   final Map<String, String> contact;

//   const ChatDetailScreen({Key? key, required this.contact}) : super(key: key);

//   @override
//   _ChatDetailScreenState createState() => _ChatDetailScreenState();
// }

// class _ChatDetailScreenState extends State<ChatDetailScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final List<Map<String, dynamic>> _messages = [];
//   final AudioPlayer _audioPlayer = AudioPlayer(); // For playback
//   String? recordingPath;
//   bool _isRecording = false;
//   bool _isPlaying = false; // Track whether the audio is playing

//   @override
//   void initState() {
//     super.initState();
//   }

//   // Function to start/stop audio recording
//   Future<void> _toggleRecording() async {
//     if (kIsWeb) {
//       // Web doesn't support audio recording with `record` package
//       print("Audio recording is not supported on the web.");
//       return;
//     }

//     // Handle recording for mobile (non-web)
//     if (_isRecording) {
//       final path = await AudioRecorder().stop();
//       if (path != null) {
//         setState(() {
//           _isRecording = false;
//           recordingPath = path;
//           _messages.add({
//             'type': 'audio',
//             'filePath': path,
//             'isSent': true,
//             'timestamp': DateTime.now().toLocal().toString().substring(11, 16),
//           });
//         });
//       }
//     } else {
//       // Request microphone permissions and start recording
//       if (await AudioRecorder().hasPermission()) {
//         final Directory appDocumentsDir =
//             await getApplicationDocumentsDirectory();
//         final String filePath =
//             p.join(appDocumentsDir.path, "recording.m4a"); // Changed to .m4a

//         await AudioRecorder().start(
//           RecordConfig(),
//           path: filePath,
//         );
//         setState(() {
//           _isRecording = true;
//           recordingPath = null;
//         });
//       }
//     }
//   }

//   // Function to play the audio file
//   // ignore: unused_element
//   Future<void> _playAudio(String filePath) async {
//     try {
//       if (_isPlaying) {
//         await _audioPlayer.pause();
//       } else {
//         // Ensure that you use the correct method for local file playback
//         if (kIsWeb) {
//           await _audioPlayer.setSourceUrl(filePath); // For web
//         } else {
//           await _audioPlayer.setSourceDeviceFile(filePath); // For mobile
//         }
//         await _audioPlayer.resume(); // Start playing the audio
//       }
//       setState(() {
//         _isPlaying = !_isPlaying; // Toggle play/pause state
//       });
//     } catch (e) {
//       print('Error playing audio: $e');
//     }
//   }

// // Function to handle file attachments
//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'pdf', 'docx', 'xlsx'],
//     );

//     if (result != null) {
//       PlatformFile file = result.files.first;

//       if (kIsWeb && file.bytes != null) {
//         // For web: handle file bytes
//         setState(() {
//           _handleFileDisplay(file);
//         });
//       } else if (!kIsWeb && file.path != null) {
//         // For mobile: handle file path
//         setState(() {
//           _handleFileDisplay(file);
//         });
//       }
//     }
//   }

// // Handle display logic for different types of files
//   void _handleFileDisplay(PlatformFile file) {
//     String fileName = file.name;
//     String? filePath = file.path;
//     String? fileFormat = p.extension(fileName).toUpperCase();
//     String fileSize = "${(file.size / 1024).toStringAsFixed(2)} KB";
//     String timestamp = DateTime.now().toLocal().toString().substring(11, 16);

//     // Handling image files
//     if (['.JPG', '.JPEG', '.PNG'].contains(fileFormat)) {
//       _messages.add({
//         'type': 'image',
//         'filePath': filePath,
//         'fileBytes': file.bytes, // For web (optional)
//         'timestamp': timestamp,
//       });
//     }
//     // Handling video files
//     else if (fileFormat == '.MP4') {
//       _messages.add({
//         'type': 'video',
//         'filePath': filePath,
//         'fileName': fileName,
//         'fileSize': fileSize,
//         'fileFormat': fileFormat,
//         'duration':
//             'Unknown', // You can enhance this with actual video duration
//         'timestamp': timestamp,
//       });
//     }
//     // Handling document files (PDF, DOCX, XLSX)
//     else if (['.PDF', '.DOCX', '.XLSX'].contains(fileFormat)) {
//       _messages.add({
//         'type': 'document',
//         'fileName': fileName,
//         'fileSize': fileSize,
//         'fileFormat': fileFormat,
//         'pages':
//             'Unknown', // You can enhance this with actual page count if needed
//         'timestamp': timestamp,
//       });
//     }
//   }

//   // Function to simulate message sending
//   void _sendMessage() {
//     if (_messageController.text.isEmpty) return;

//     setState(() {
//       _messages.add({
//         'text': _messageController.text,
//         'isSent': true,
//         'type': 'text',
//         'timestamp': DateTime.now().toLocal().toString().substring(11, 16),
//       });
//     });

//     _messageController.clear();

//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//         _messages.add({
//           'text': 'Got your message!',
//           'isSent': false,
//           'type': 'text',
//           'timestamp': DateTime.now().toLocal().toString().substring(11, 16),
//         });
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _audioPlayer
//         .dispose(); // Dispose of the AudioPlayer when the screen is closed
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0E5F85),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: GestureDetector(
//           onTap: () {
//             // Navigate to the ContactInfo screen when tapped
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ContactInfo(contact: widget.contact),
//               ),
//             );
//           },
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: AssetImage(widget.contact['image']!),
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 widget.contact['name']!,
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.call_outlined, color: Colors.white),
//             onPressed: () {
//               String userName = widget.contact['name']!;
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AudioCallScreen(
//                     audioImage: widget.contact['image']!,
//                     userName: userName,
//                     callStatus: 'Calling',
//                   ),
//                 ),
//               );
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.videocam_outlined, color: Colors.white),
//             onPressed: () {
//               String userName = widget.contact['name']!;
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => VideoCallScreen(
//                     videoImage: widget.contact['image']!,
//                     userName: userName,
//                     callStatus: 'Calling',
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               color: Colors.white,
//               child: ListView.builder(
//                 itemCount: _messages.length,
//                 reverse: true,
//                 itemBuilder: (context, index) {
//                   final message = _messages[_messages.length - 1 - index];

//                   if (message['type'] == 'image') {
//                     return Align(
//                       alignment: message['isSent']
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: Column(
//                         crossAxisAlignment: message['isSent']
//                             ? CrossAxisAlignment.end
//                             : CrossAxisAlignment.start,
//                         children: [
//                           Image.file(
//                             File(message['filePath'] ?? ''), // For mobile
//                             width: 150,
//                             height: 150,
//                             fit: BoxFit.cover,
//                           ),
//                           Text(
//                             message['timestamp'],
//                             style: TextStyle(
//                                 color: message['isSent']
//                                     ? Colors.white54
//                                     : Colors.black54,
//                                 fontSize: 10),
//                           ),
//                         ],
//                       ),
//                     );
//                   } else if (message['type'] == 'document') {
//                     return Align(
//                       alignment: message['isSent']
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 5, horizontal: 10),
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: message['isSent']
//                               ? const Color.fromARGB(255, 14, 95, 133)
//                               : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               message['fileName'],
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: message['isSent']
//                                     ? Colors.white
//                                     : Colors.black,
//                               ),
//                             ),
//                             Text(
//                               '${message['pages']} pages, ${message['fileSize']}, ${message['fileFormat']}',
//                               style: TextStyle(
//                                 color: message['isSent']
//                                     ? Colors.white
//                                     : Colors.black,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Text(
//                               message['timestamp'],
//                               style: const TextStyle(
//                                 color: Colors.white54,
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   } else if (message['type'] == 'video') {
//                     return Align(
//                       alignment: message['isSent']
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 5, horizontal: 10),
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: message['isSent']
//                               ? const Color.fromARGB(255, 14, 95, 133)
//                               : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               message['fileName'],
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: message['isSent']
//                                     ? Colors.white
//                                     : Colors.black,
//                               ),
//                             ),
//                             Text(
//                               '${message['fileSize']}, ${message['fileFormat']}, Duration: ${message['duration']}',
//                               style: TextStyle(
//                                 color: message['isSent']
//                                     ? Colors.white
//                                     : Colors.black,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Text(
//                               message['timestamp'],
//                               style: const TextStyle(
//                                 color: Colors.white54,
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   } else {
//                     // Text message handling (existing)
//                     return Align(
//                       alignment: message['isSent']
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 5, horizontal: 10),
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: message['isSent']
//                               ? const Color.fromARGB(255, 14, 95, 133)
//                               : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               message['text'],
//                               style: TextStyle(
//                                 color: message['isSent']
//                                     ? Colors.white
//                                     : Colors.black,
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Text(
//                               message['timestamp'],
//                               style: const TextStyle(
//                                 color: Colors.white54,
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ),
//           ),
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageInput() {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       color: Colors.white,
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _messageController,
//               decoration: InputDecoration(
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                 hintText: 'Type a message',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[200],
//               ),
//             ),
//           ),
//           const SizedBox(width: 10),
//           IconButton(
//             icon: const Icon(Icons.attach_file, color: Colors.black54),
//             onPressed: _pickFile,
//           ),
//           const SizedBox(width: 5),
//           IconButton(
//             icon: const Icon(Icons.mic, color: Colors.black54),
//             onPressed: _toggleRecording,
//           ),
//           const SizedBox(width: 5),
//           IconButton(
//             icon: const Icon(Icons.send, color: Color(0xFF0E5F85)),
//             onPressed: _sendMessage,
//           ),
//         ],
//       ),
//     );
//   }
// }
