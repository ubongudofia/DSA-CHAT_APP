import 'package:flutter/material.dart';

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  int _selectedIndex = 1; // Index for Call Screen

  // Sample call log data
  final List<Map<String, String>> _callLogs = [
    {
      'name': 'Alice',
      'time': 'Yesterday, 10:30 AM',
      'status': 'Missed',
      'image': 'assets/images/Ubong-Peters1.png'
    },
    {
      'name': 'Bob',
      'time': 'Today, 8:00 AM',
      'status': 'Incoming',
      'image': 'assets/images/Paul-Emeka1.png'
    },
    {
      'name': 'Charlie',
      'time': 'Today, 6:00 AM',
      'status': 'Outgoing',
      'image': 'assets/images/greg.jpg'
    },
  ];

  // Users for mock call selection
  final List<Map<String, String>> _mockUsers = [
    {'name': 'David', 'image': 'assets/images/james.jpg'},
    {'name': 'Eva', 'image': 'assets/images/Sophia.jpg'},
    {'name': 'Frank', 'image': 'assets/images/Steven.jpg'},
  ];

  List<Map<String, String>> _selectedUsers =
      []; // Store selected users for a call

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
        Navigator.pushNamed(context, '/contact_screen');
        break;
      case 3:
        Navigator.pushNamed(context, '/settings_screen');
        break;
    }
  }

  // Sliding up modal to select users for a call
  void _openSlidingUpModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize:
              0.75, // Set the initial size to 75% of the screen height
          minChildSize: 0.75, // Minimum size for sliding
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // New Call Options at the top of the overlay
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'New Call Options',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person_add, color: Colors.blue),
                    title: Text('New Contact'),
                    onTap: () {
                      // Handle new contact action
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.group, color: Colors.blue),
                    title: Text('New Group'),
                    onTap: () {
                      // Handle new group action
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.blue),
                    title: Text('Settings'),
                    onTap: () {
                      // Handle settings action
                    },
                  ),
                  Divider(),

                  // Selected users displayed on top of the overlay
                  if (_selectedUsers.isNotEmpty)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _selectedUsers.map((user) {
                          return Stack(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: AssetImage(user['image']!),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedUsers.remove(user);
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.red,
                                    child: Icon(Icons.close,
                                        size: 14, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  const SizedBox(height: 16),

                  // List of mock users to select for the call
                  Text('Add Call',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: _mockUsers.length,
                      itemBuilder: (context, index) {
                        final user = _mockUsers[index];
                        bool isSelected = _selectedUsers.contains(user);
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(user['image']!),
                          ),
                          title: Text(user['name']!),
                          trailing: Checkbox(
                            shape:
                                CircleBorder(), // Changed checkbox shape to circular
                            value: isSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  _selectedUsers.add(user);
                                } else {
                                  _selectedUsers.remove(user);
                                }
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Navigation to the detailed call screen
  void _navigateToCallScreen(
      BuildContext context, String callType, String userName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailedCallScreen(callType: callType, userName: userName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back arrow
        backgroundColor: Colors.white,
        title: Text(
          'Calls',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 10), // Space between search bar and contacts

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent calls',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Display recent calls using ListView.builder
          Expanded(
            child: ListView.builder(
              itemCount: _callLogs.length,
              itemBuilder: (context, index) {
                final callLog = _callLogs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(callLog['image']!),
                      ),
                      const SizedBox(
                          width: 16), // Spacing between image and text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              callLog['name']!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              callLog['status']!,
                              style: TextStyle(
                                color: _getCallStatusColor(callLog['status']!),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              callLog['time']!,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.call),
                            color: Colors.green,
                            onPressed: () => _navigateToCallScreen(
                                context, 'audio', callLog['name']!),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: Icon(Icons.videocam),
                            color: Colors.blue,
                            onPressed: () => _navigateToCallScreen(
                                context, 'video', callLog['name']!),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openSlidingUpModal(context),
        backgroundColor: Colors.green,
        child: Icon(Icons.add_call, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  // Method to get call status color
  Color _getCallStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'missed':
        return Colors.red;
      case 'incoming':
        return Colors.green;
      case 'outgoing':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

class DetailedCallScreen extends StatelessWidget {
  final String callType;
  final String userName;

  const DetailedCallScreen({required this.callType, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$callType Call with $userName'),
      ),
      body: Center(
        child: Text('Call Details for $userName ($callType)'),
      ),
    );
  }
}
