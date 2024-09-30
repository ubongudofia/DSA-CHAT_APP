
  // // Function to show the modal bottom sheet
  // void _showSlidingOverlay() {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true, // Make it slide all the way up
  //     backgroundColor: Colors.transparent, // Transparent background for the sheet
  //     builder: (context) {
  //       return DraggableScrollableSheet(
  //         expand: false,
  //         initialChildSize: 0.4, // Start size (40% of the screen)
  //         maxChildSize: 0.8, // Max size (80% of the screen)
  //         builder: (context, scrollController) {
  //           return Container(
  //             decoration: BoxDecoration(
  //               color: Colors.white, // White background for the sheet
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(20),
  //                 topRight: Radius.circular(20),
  //               ),
  //             ),
  //             child: ListView(
  //               controller: scrollController,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(16.0),
  //                   child: Text(
  //                     'New Chat Options',
  //                     style: TextStyle(
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //                 ListTile(
  //                   leading: Icon(Icons.person_add, color: Colors.blue),
  //                   title: Text('New Contact'),
  //                   onTap: () {
  //                     // Handle new contact action
  //                   },
  //                 ),
  //                 ListTile(
  //                   leading: Icon(Icons.group, color: Colors.blue),
  //                   title: Text('New Group'),
  //                   onTap: () {
  //                     // Handle new group action
  //                   },
  //                 ),
  //                 ListTile(
  //                   leading: Icon(Icons.settings, color: Colors.blue),
  //                   title: Text('Settings'),
  //                   onTap: () {
  //                     // Handle settings action
  //                   },
  //                 ),
  //                 // Add more options as needed
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }