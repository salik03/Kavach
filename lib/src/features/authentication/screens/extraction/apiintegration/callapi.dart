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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: callLogs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _showCallLogDetailsDialog(callLogs[index]);
            },
            child: ListTile(
              title: Text(callLogs[index].name ?? callLogs[index].number!),
              subtitle: Text(callLogs[index].number!),
            ),
          );
        },
      ),
    );
  }

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




class _SpamTypeButtons extends StatefulWidget {
  final CallLogEntry callLog;

  const _SpamTypeButtons({
    Key? key,
    required this.callLog,
  }) : super(key: key);

  @override
  _SpamTypeButtonsState createState() => _SpamTypeButtonsState();
}

class _SpamTypeButtonsState extends State<_SpamTypeButtons> {
  String _selectedSpamType = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Spam Type:'),
        Wrap(
          spacing: 8,
          children: [
            _SpamTypeButton(label: 'Normal', spamType: 'Normal'),
            _SpamTypeButton(label: 'Robocalls', spamType: 'Robocalls'),
            _SpamTypeButton(label: 'Scams', spamType: 'Scams'),
            _SpamTypeButton(label: 'Caller ID Spoofing', spamType: 'Caller ID Spoofing'),
            _SpamTypeButton(label: 'Tech Support Scams', spamType: 'Tech Support Scams'),
            _SpamTypeButton(label: 'Debt Collection', spamType: 'Debt Collection'),
          ],
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _selectedSpamType.isNotEmpty
              ? () {
            _sendLogToApi(widget.callLog, _selectedSpamType);
          }
              : null,
          child: Text('Send Log to API'),
        ),
      ],
    );
  }

  void _sendLogToApi(CallLogEntry callLog, String spamType) {
    String phoneNumber = callLog.number!;
    String duration = callLog.duration.toString();
    String timestamp = callLog.timestamp!.toString();
    String inContact = callLog.name != null ? 'Yes' : 'No'; // Assuming inContact means whether the caller is in the contacts or not
    String callType = _getCallTypeString(callLog.callType!);
    String userAuthId = ''; // Retrieve user auth ID from SharedPreferences

    CallDataHandler.sendCallData(phoneNumber, duration, timestamp, inContact, callType, spamType, userAuthId);
  }




  String _getCallTypeString(CallType callType) {
  switch (callType) {
  case CallType.incoming:
  return "Incoming";
  case CallType.outgoing:
  return "Outgoing";
  case CallType.missed:
  return "Missed";
  case CallType.rejected:
  return "Rejected";
  case CallType.blocked:
  return "Blocked";
  case CallType.voiceMail:
  return "Voicemail";
  default:
  return "Unknown";
  }
  }
  }

  void _updateSelectedSpamType(String spamType) {
  setState(() {
  _selectedSpamType = spamType;
  });
  }

  Widget _SpamTypeButton({required String label, required String spamType}) {
    return ElevatedButton(
      onPressed: () => _updateSelectedSpamType(spamType),
      child: Text(label),
      style: ElevatedButton.styleFrom(
        primary: _selectedSpamType == spamType ? Colors.teal : null,
      ),
    );
  }
}


