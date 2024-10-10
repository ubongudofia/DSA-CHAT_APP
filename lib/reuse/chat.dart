// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:record/record.dart';
// import 'package:audioplayers/audioplayers.dart'; // For playing audio
// import 'package:path/path.dart' as p;

// import './audio_call_screen.dart';
// import './video_call_screen.dart';

// class ChatDetailScreen extends StatefulWidget {
//   final Map<String, String> contact;

//   const ChatDetailScreen({Key? key, required this.contact}) : super(key: key);

//   @override
//   _ChatDetailScreenState createState() => _ChatDetailScreenState();
// }

// class _ChatDetailScreenState extends State<ChatDetailScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final List<Map<String, dynamic>> _messages = [];
//   final AudioRecorder _audioRecorder = AudioRecorder(); // Declare Record here
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
//     if (_isRecording) {
//       final path = await _audioRecorder.stop();
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
//       if (await _audioRecorder.hasPermission()) {
//         final Directory appDocumentsDir =
//             await getApplicationDocumentsDirectory();
//         final String filePath =
//             p.join(appDocumentsDir.path, "recording.m4a"); // Changed to .m4a

//         await _audioRecorder.start(
//           const RecordConfig(),
//           path: filePath,
//           // encoder: AudioEncoder.aacLc, // Specify encoder
//           // bitRate: 128000, // Bitrate for better quality
//           // sampleRate: 44100, // Sampling rate for better quality
//         );
//         setState(() {
//           _isRecording = true;
//           recordingPath = null;
//         });
//       }
//     }
//   }

//   // Function to play the audio file
//   Future<void> _playAudio(String filePath) async {
//     try {
//       if (_isPlaying) {
//         await _audioPlayer.pause();
//       } else {
//         await _audioPlayer
//             .setSourceUrl(filePath); // Set the source as a local file
//         await _audioPlayer.resume(); // Start playing the audio
//       }
//       setState(() {
//         _isPlaying = !_isPlaying; // Toggle play/pause state
//       });
//     } catch (e) {
//       print('Error playing audio: $e');
//     }
//   }

//   // Function to handle file attachments
//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'pdf', 'docx', 'xlsx'],
//     );

//     if (result != null && result.files.first.path != null) {
//       PlatformFile file = result.files.first;
//       setState(() {
//         _messages.add({
//           'text': file.name,
//           'isSent': true,
//           'type': 'file',
//           'filePath': file.path,
//           'timestamp': DateTime.now().toLocal().toString().substring(11, 16),
//         });
//       });
//     } else {
//       print('No file selected');
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
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: AssetImage(widget.contact['image']!),
//             ),
//             const SizedBox(width: 10),
//             Text(
//               widget.contact['name']!,
//               style: const TextStyle(color: Colors.white),
//             ),
//           ],
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
//                   if (message['type'] == 'audio') {
//                     return Align(
//                       alignment: message['isSent']
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(
//                                 _isPlaying ? Icons.pause : Icons.play_arrow),
//                             onPressed: () {
//                               _playAudio(message['filePath']);
//                             },
//                           ),
//                           Text(
//                             message['timestamp'],
//                             style: TextStyle(
//                               color: message['isSent']
//                                   ? Colors.white54
//                                   : Colors.black54,
//                               fontSize: 10,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   } else if (message['type'] == 'file') {
//                     return Align(
//                       alignment: message['isSent']
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: TextButton(
//                         onPressed: () {
//                           // Open the file
//                         },
//                         child: Text(
//                           message['text'],
//                           style: TextStyle(
//                             color:
//                                 message['isSent'] ? Colors.blue : Colors.black,
//                           ),
//                         ),
//                       ),
//                     );
//                   } else {
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
//           Container(
//             padding: const EdgeInsets.all(10),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: const InputDecoration(
//                       hintText: "Type a message...",
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     _isRecording ? Icons.mic : Icons.mic_none,
//                     color: Colors.red,
//                   ),
//                   onPressed: _toggleRecording,
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.attach_file),
//                   onPressed: _pickFile,
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
