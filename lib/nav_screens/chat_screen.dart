// lib/screens/chat_screen.dart
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 0; // Index of the current active screen (Chat)

  // Function to handle bottom navigation bar item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/chat_screen');
        break;
      case 1:
        Navigator.pushNamed(context, '/call_screen');
        break;
      case 2:
        Navigator.pushNamed(context, '/contact_screens');
        break;
      case 3:
        Navigator.pushNamed(context, '/settings_screen');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // White background for AppBar
        elevation: 0, // No shadow for AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Back arrow
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Centered "Chats" title
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Chats',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search chat',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon:
                    const Icon(Icons.search), // Search icon in the text field
              ),
            ),
          ),
          const SizedBox(height: 20), // Space between search bar and chat list

          // Chat list
          Expanded(
            child: ListView.builder(
              itemCount: 3, // For demonstration, replace with your contact list
              itemBuilder: (context, index) {
                final chatContact = {
                  'name': 'User $index',
                  'bio': 'Last message from User $index',
                  'image': 'assets/images/dsa-logo.png', // Placeholder image
                };
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            chatContact['image']!), // Load chat contact image
                      ),
                      title: Text(
                        chatContact['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        chatContact['bio']!,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () {
                        // Navigate to chat detail screen if needed
                      },
                    ),
                    Divider(color: Colors.grey[300]), // Light grey divider
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200], // Light grey background
        type: BottomNavigationBarType.fixed, // Fixed navigation bar
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Call',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex, // The current active index
        onTap: _onItemTapped, // Handle item tap
        selectedItemColor:
            const Color.fromARGB(255, 14, 95, 133), // Active color (blue)
        unselectedItemColor: Colors.grey, // Inactive icons and text color
        showUnselectedLabels: true, // Show text labels for inactive items
        selectedIconTheme: const IconThemeData(
            size: 30,
            color: Color.fromARGB(
                255, 14, 95, 133)), // Larger solid icon for active
        unselectedIconTheme: const IconThemeData(
            size: 24, color: Colors.grey), // Regular icon for inactive
      ),
    );
  }
}
