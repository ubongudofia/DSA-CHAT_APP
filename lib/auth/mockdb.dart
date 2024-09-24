//import 'package:flutter/material.dart';

// lib/mock_data.dart
class MockDatabase {
  static List<Map<String, String>> users = [
    {
      'service_number': '123456',
      'name': 'John Doe',
      'phone_number': '09051234567',
      'email': 'john@example.com'
    },
    {
      'service_number': '654321',
      'name': 'Jane Smith',
      'phone_number': '09057654321',
      'email': 'jane@example.com'
    },
  ];

  static Map<String, String>? findUserByServiceNumber(String serviceNumber) {
    return users.firstWhere(
      (user) => user['service_number'] == serviceNumber,
      orElse: () => <String, String>{}, // Return an empty map instead of null
    );
  }
}
