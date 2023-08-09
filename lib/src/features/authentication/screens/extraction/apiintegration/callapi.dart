import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:call_log/call_log.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:http/http.dart' as http;

class SpamApiController {
  final String baseUrl = 'https://nischal-backend.onrender.com/api/v1/call/incoming';

  Future<Map<String, dynamic>> fetchSpamStatus(Map<String, dynamic> postData) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        print('Failed to fetch spam status. Status code: ${response.statusCode}');
        throw Exception('Failed to fetch spam status.');
      }
    } catch (e) {
      print('Error while fetching spam status: $e');
      rethrow;
    }
  }
}

class PhonelogsScreenApi extends StatefulWidget {
  @override
  _PhonelogsScreenState createState() => _PhonelogsScreenState();
}

class _PhonelogsScreenState extends State<PhonelogsScreenApi> {
  List<CallLogEntry> callLogs = [];
  String? storedUserId;

  @override
  void initState() {
    super.initState();
    _getCallLogs();
    _loadUserId();
  }

  Future<void> _getCallLogs() async {
    Iterable<CallLogEntry> entries = await CallLog.query();
    setState(() {
      callLogs = entries.toList().take(10).toList();
    });
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    storedUserId = prefs.getString('user_id');
  }

  Future<Contact?> _getContactForNumber(String phoneNumber) async {
    Iterable<Contact> contacts = await ContactsService.getContactsForPhone(phoneNumber);
    if (contacts.isNotEmpty) {
      return contacts.first;
    }
    return null;
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

  Future<void> _sendCallLogData(CallLogEntry callLog) async {
    if (storedUserId != null && callLog.callType != CallType.unknown) {
      SpamApiController apiController = SpamApiController();

      String callerName = await _getContactName(callLog.number ?? "");
      if (callerName == "Unknown Contact") {
        callerName = "";
      }

      Map<String, dynamic> callData = {
        "caller_phone_number": callLog.number ?? "",
        "call_duration": callLog.duration.toString(),
        "call_timestamp": callLog.timestamp?.toString() ?? "",
        "caller_in_contact": callerName,
        "call_type": _getCallTypeString(callLog.callType!),
        "user_auth_id": storedUserId!,
      };

      try {
        Map<String, dynamic> spamStatusResponse = await apiController.fetchSpamStatus(callData);
        String spamStatus = spamStatusResponse['spamStatus'];
        String spamScore = spamStatusResponse['spamScore'];
        String spamMessage = spamStatusResponse['message'];

        print('Spam Status: $spamStatus');
        print('Spam Score: $spamScore');
        print('Message: $spamMessage');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('call_log_response_${callLog.hashCode}', jsonEncode(spamStatusResponse));
        print('Response stored in local storage.');
      } catch (e) {
        print('Error sending call log data: $e');
      }
    } else {
      print('User ID not found in SharedPreferences or call type unknown.');
    }
  }

  Future<String> _getContactName(String phoneNumber) async {
    Contact? contact = await _getContactForNumber(phoneNumber);
    if (contact != null) {
      return contact.displayName ?? "Unknown Contact";
    }
    return "Unknown Contact";
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Logs'),
      ),
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
    String formattedTimestamp = "Unknown Timestamp";

    if (callLog.timestamp != null) {
      formattedTimestamp = DateFormat.yMd().add_Hms().format(
        DateTime.fromMillisecondsSinceEpoch(callLog.timestamp!),
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.red, width: 5),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          title: Center(child: Text("Call Log Details")),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Add the spam status box here
              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FutureBuilder<Map<String, dynamic>>(
                  future: _fetchSpamStatus(callLog),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading...");
                    } else if (snapshot.hasError) {
                      return Text("Error");
                    } else {
                      String spamStatus = snapshot.data?['spamStatus'] ?? "Unknown";
                      return Center(
                        child: Text(
                          spamStatus,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Text("Name: ${callLog.name ?? 'Unknown'}"),
                    Text("Number: ${callLog.number}"),
                    Text("Call Type: ${_getCallTypeString(callLog.callType!)}"),
                    Text("Call Duration: ${callLog.duration} seconds"),
                    Text("Call Time Stamp: $formattedTimestamp"),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _sendCallLogData(callLog);
              },
              child: Text("Send to API"),
            ),
            TextButton(
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

  Future<Map<String, dynamic>> _fetchSpamStatus(CallLogEntry callLog) async {
    String callerName = await _getContactName(callLog.number ?? "");
    if (callerName == "Unknown Contact") {
      callerName = "";
    }

    Map<String, dynamic> callData = {
      "caller_phone_number": callLog.number ?? "",
      "call_duration": callLog.duration.toString(),
      "call_timestamp": callLog.timestamp?.toString() ?? "",
      "caller_in_contact": callerName,
      "call_type": _getCallTypeString(callLog.callType!),
      "user_auth_id": storedUserId!,
    };

    SpamApiController apiController = SpamApiController();
    return await apiController.fetchSpamStatus(callData);
  }
}
