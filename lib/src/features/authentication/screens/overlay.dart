import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// API Controller

class CallApiController {
  final String baseUrl = 'https://nischal-backend.onrender.com/api/v1/call/incoming';

  Future<String> postCallData(Map<String, dynamic> data) async {
    // ... (same as before)
  }
}

// Data Models

class UserData {
  // ... (same as before)
}

// Data Handling

class CallDataHandler {
  // ... (same as before)
}

// UI Components

class PhonelogsScreen extends StatefulWidget {
  // ... (same as before)
}

class _PhonelogsScreenState extends State<PhonelogsScreen> {
  // ... (same as before)
}

class _SpamTypeButtons extends StatefulWidget {
  // ... (same as before)
}

class _SpamTypeButtonsState extends State<_SpamTypeButtons> {
  // ... (same as before)
}

// Helper Functions

String _getCallTypeString(CallType callType) {
  // ... (same as before)
}

void _updateSelectedSpamType(String spamType) {
  // ... (same as before)
}

Widget _SpamTypeButton({required String label, required String spamType}) {
  // ... (same as before)
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Logs App',
      home: PhonelogsScreen(),
    );
  }
}
