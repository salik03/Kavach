import 'dart:convert';

import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  String calledPhoneNumber;
  String calledDuration;
  String calledTimestamp;
  String calledIncontact;
  String calledType;
  String callSpam;
  String userAuthId;

  UserData({
    required this.calledPhoneNumber,
    required this.calledDuration,
    required this.calledTimestamp,
    required this.calledIncontact,
    required this.calledType,
    required this.callSpam,
    required this.userAuthId,
  });

  Map<String, dynamic> toJson() {
    return {
      "caller_phone_number": calledPhoneNumber,
      "call_duration": calledDuration,
      "call_timestamp": calledTimestamp,
      "caller_in_contact": calledIncontact,
      "call_type": calledType,
      "call_spam": callSpam,
      "user_auth_id": userAuthId
    };
  }
}

class CallApiController {
  final String baseUrl = 'https://nischal-backend.onrender.com/api/v1/call/incoming';

  Future<String> postCallData(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print('POST request successful.');
        return response.body;
      } else {
        print('Failed to make a POST request. Status code: ${response.statusCode}');
        throw Exception('Failed to make a POST request.');
      }
    } catch (e) {
      print('Error while making POST request: $e');
      throw e;
    }
  }
}

class PhonelogsScreen extends StatefulWidget {
  @override
  _PhonelogsScreenState createState() => _PhonelogsScreenState();
}

class _PhonelogsScreenState extends State<PhonelogsScreen> {
  List<CallLogEntry> callLogs = [];

  @override
  void initState() {
    super.initState();
    _getCallLogs();
  }

  Future<void> _getCallLogs() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    setState(() {
      callLogs = entries.toList();
    });
  }

  String _getCallTypeString(CallType callType) {
    // Define this function as per your needs
  }

  void _sendCallDataToApi(UserData userData) async {
    // Define the logic to send data to API using CallApiController
  }

  void _showSpamOptionsDialog(CallLogEntry callLog) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Mark Call as Spam"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  _markCallAsSpam(callLog, "Normal");
                },
                child: Text("Normal"),
              ),
              // Add buttons for other spam types here
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _markCallAsSpam(CallLogEntry callLog, String spamType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUserId = prefs.getString('user_id');

    if (storedUserId != null) {
      UserData userData = UserData(
        calledPhoneNumber: callLog.number!,
        calledDuration: callLog.duration.toString(),
        calledTimestamp: callLog.timestamp!.toString(),
        calledIncontact: callLog.name ?? '',
        calledType: _getCallTypeString(callLog.callType!),
        callSpam: spamType,
        userAuthId: storedUserId,
      );

      _sendCallDataToApi(userData);
    } else {
      print('User ID not found in SharedPreferences.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: callLogs.length,
        itemBuilder: (context, index) {
          CallLogEntry callLog = callLogs[index];
          return GestureDetector(
            onTap: () {
              _showCallLogDetailsDialog(callLog);
            },
            child: ListTile(
              title: Text(callLog.name ?? callLog.number!),
              subtitle: Text(callLog.number!),
              trailing: ElevatedButton(
                onPressed: () {
                  _showSpamOptionsDialog(callLog);
                },
                child: Text("Mark Spam"),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCallLogDetailsDialog(CallLogEntry callLog) {
    // Define the logic to show call log details dialog
  }
}
