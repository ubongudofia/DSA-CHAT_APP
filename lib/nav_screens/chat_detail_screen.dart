// lib/screens/chat_detail_screen.dart
import 'package:flutter/material.dart';
import './audio_call_screen.dart';
import './video_call_screen.dart';

class ChatDetailScreen extends StatefulWidget {
  final Map<String, String> contact; // The specific contact details

  const ChatDetailScreen({Key? key, required this.contact}) : super(key: key);

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = []; // List to store messages

  // Function to simulate message sending
  void _sendMessage() {
    if (_messageController.text.isEmpty) return;

    setState(() {
      _messages.add({
        'text': _messageController.text,
        'isSent': true, // Message is from the current user
        'timestamp': DateTime.now()
            .toLocal()
            .toString()
            .substring(11, 16), // Time in HH:MM format
      });
    });

    _messageController.clear();

    // Simulate a response from the contact after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add({
          'text': 'Got your message!',
          'isSent': false, // Message is from the contact
          'timestamp': DateTime.now()
              .toLocal()
              .toString()
              .substring(11, 16), // Time in HH:MM format
        });
      });
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E5F85), // Blue background color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // White back arrow
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  AssetImage(widget.contact['image']!), // Contact image
            ),
            const SizedBox(width: 10),
            Text(
              widget.contact['name']!, // Contact name
              style: const TextStyle(color: Colors.white), // White text color
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call_outlined, color: Colors.white),
            onPressed: () {
              String userName = widget.contact['name']!;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AudioCallScreen(
                    audioImage: widget.contact['image']!,
                    userName: userName,
                    callStatus: 'Calling', // Example: Change status as needed
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam_outlined, color: Colors.white),
            onPressed: () {
              // Assuming `selectedUser` is the user currently selected or in the call
              String userName =
                  widget.contact['name']!; // Get the name dynamically

              // Navigate to VideoCallScreen with the dynamically retrieved name
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoCallScreen(
                    videoImage: widget.contact['image']!,
                    userName: userName,
                    callStatus: 'Calling',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white, // White background for chat body
              child: ListView.builder(
                itemCount: _messages.length, // Number of messages
                reverse: true, // Show the latest message at the bottom
                itemBuilder: (context, index) {
                  final message = _messages[_messages.length - 1 - index];
                  return Align(
                    alignment: message['isSent']
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: message['isSent']
                            ? const Color.fromARGB(255, 14, 95, 133)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            message['text'],
                            style: TextStyle(
                                color: message['isSent']
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            message['timestamp'],
                            style: const TextStyle(
                                fontSize: 10, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Message input field and send button
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            decoration: const BoxDecoration(
              color: Color(0xFFEDF2FA), // Background color hex #EDF2FA
            ),
            child: Row(
              children: [
                // Attachment icon
                IconButton(
                  icon: const Icon(Icons.attach_file_outlined),
                  onPressed: () {
                    // Handle attachment
                  },
                ),
                // Recording icon
                IconButton(
                  icon: const Icon(Icons.mic_none_outlined),
                  onPressed: () {
                    // Handle voice recording
                  },
                ),
                // Text input field
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Send button
                FloatingActionButton(
                  onPressed: _sendMessage,
                  mini: true,
                  backgroundColor: const Color.fromARGB(255, 14, 95, 133),
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
