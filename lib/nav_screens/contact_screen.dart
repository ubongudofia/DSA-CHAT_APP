// lib/screens/contact_screen.dart
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  int _selectedIndex = 2; // Index of the current active screen (Contact)

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
        Navigator.pushNamed(context, '/contact_screen');
        break;
      case 3:
        Navigator.pushNamed(context, '/settings_screen');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // List of contacts
    final contacts = [
      {
        'name': 'John Doe',
        'bio': 'God is good',
        'image': 'assets/images/james.jpg', // Ensure this image exists
      },
      {
        'name': 'Jane Smith',
        'bio': 'Busy',
        'image': 'assets/images/sophia.jpg', // Ensure this image exists
      },
      {
        'name': 'Mike Johnson',
        'bio': 'Only calls',
        'image': 'assets/images/steven.jpg', // Ensure this image exists
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // White background for AppBar
        elevation: 0, // No shadow for AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Back arrow
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Centered "Contacts" title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Contacts',
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
                hintText: 'Search name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: Icon(Icons.search), // Search icon in the text field
              ),
            ),
          ),
          SizedBox(height: 20), // Space between search bar and contacts

          // Contact list
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length, // Use the length of the contacts list
              itemBuilder: (context, index) {
                final contact = contacts[index]; // Get the current contact
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            contact['image']!), // Use null assertion operator
                      ),
                      title: Text(
                        contact['name']!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        contact['bio']!,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: TextButton(
                        onPressed: () {
                          // Add functionality here (e.g., add to favorites)
                        },
                        child: Text('Add'),
                      ),
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
        selectedIconTheme: IconThemeData(
            size: 30,
            color: Color.fromARGB(
                255, 14, 95, 133)), // Larger solid icon for active
        unselectedIconTheme: IconThemeData(
            size: 24, color: Colors.grey), // Regular icon for inactive
      ),
    );
  }
}
