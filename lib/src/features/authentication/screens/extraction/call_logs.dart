import 'package:call_log/call_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              // Text("Call Type: ${_getCallTypeString(callLogs as CallType)}"),
              Text("Call Duration: ${callLog.duration} seconds"),
            ],
          ),
          actions: [
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
}

//Outcoming: 0, Incoming:1