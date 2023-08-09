import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:call_log/call_log.dart';
import 'package:contacts_service/contacts_service.dart';
import '../../../controllers/call_api_controller.dart';

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

  Future<Contact?> _getContactForNumber(String phoneNumber) async {
    Iterable<Contact> contacts = await ContactsService.getContactsForPhone(phoneNumber);
    if (contacts.isNotEmpty) {
      return contacts.first;
    }
    return null;
  }

  Future<void> _getCallLogs() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    setState(() {
      callLogs = entries.toList().take(10).toList();
    });
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    storedUserId = prefs.getString('user_id');
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
          title: Text("Call Log Details"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Name: ${callLog.name ?? 'Unknown'}"),
              Text("Number: ${callLog.number}"),
              Text("Call Type: ${_getCallTypeString(callLog.callType!)}"),
              Text("Call Duration: ${callLog.duration} seconds"),
              Text("Call Time Stamp: $formattedTimestamp"),
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
      CallApiController apiController = CallApiController();

      String callerName = await _getContactName(callLog.number ?? "");
      if (callerName == "Unknown Contact") {
        // Handle unknown contact gracefully.
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
        String response = await apiController.postCallData(callData);
        print('Call log data sent successfully. Response: $response');

        // Store the response in local storage using SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('call_log_response_${callLog.hashCode}', response);
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
}