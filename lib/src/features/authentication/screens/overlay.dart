/*
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
      "user_auth_id": userAuthId,
    };
  }
}

class CallDataHandler {
  static Future<void> sendCallData(
      String phoneNumber,
      String duration,
      String timestamp,
      String inContact,
      String callType,
      String callSpam,
      String userAuthId,
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUserId = prefs.getString('user_id');

    if (storedUserId != null) {
      UserData userData = UserData(
        calledPhoneNumber: phoneNumber,
        calledDuration: duration,
        calledTimestamp: timestamp,
        calledIncontact: inContact,
        calledType: callType,
        callSpam: callSpam,
        userAuthId: userAuthId,
      );

      CallApiController apiController = CallApiController();
      Map<String, dynamic> postData = userData.toJson();

      try {
        await apiController.postCallData(postData);
        print('Call data sent successfully.');
      } catch (e) {
        print('Error sending call data: $e');
      }
    } else {
      print('User ID not found in SharedPreferences.');
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




  // ... (same as before)

  void _showCallLogDetailsDialog(CallLogEntry callLog) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Call Log Details"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Name: ${callLog.name ?? 'Unknown'}"),
              Text("Number: ${callLog.number}"),
              Text("Call Type: ${_getCallTypeString(callLog.callType!)}"),
              Text("Call Duration: ${callLog.duration} seconds"),
              _SpamTypeButtons(callLog: callLog),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  // ... (same as before)

  String _getCallTypeString(CallType callType) {
    // ... (same as before)
  }
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
  runApp(MaterialApp(
    home: PhonelogsScreen(),
  ));
}
*/
