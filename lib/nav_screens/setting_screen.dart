// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 3; // Index for Settings Screen

  // Handle navigation on the bottom bar
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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Example of settings options - replace with actual settings
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Demonstration
              itemBuilder: (context, index) {
                final setting = {'option': 'Option $index'};
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        setting['option']!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(color: Colors.grey[300]),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        type: BottomNavigationBarType.fixed,
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 14, 95, 133),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedIconTheme:
            IconThemeData(size: 30, color: Color.fromARGB(255, 14, 95, 133)),
        unselectedIconTheme: IconThemeData(size: 24, color: Colors.grey),
      ),
    );
  }
}
