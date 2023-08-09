import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SMSScreen extends StatefulWidget {
  const SMSScreen({Key? key}) : super(key: key);

  @override
  State<SMSScreen> createState() => _SMSScreenState();
}

class _SMSScreenState extends State<SMSScreen> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];
  String? _userAuthId;

  @override
  void initState() {
    super.initState();
    _loadUserAuthId();
  }

  Future<void> _loadUserAuthId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userAuthId = prefs.getString('user_id');
    });
  }

  void _sendLogToApi(String smsSender, String smsName, String smsContent, String smsSpamType) async {
    if (_userAuthId != null) {
      Map<String, dynamic> postData = {
        "phone_number_of_messenger": smsSender,
        "called_name": smsName,
        "message_content": smsContent,
        "call_spam": smsSpamType,
        "user_auth_id": _userAuthId,
      };

      final response = await http.post(
        Uri.parse('https://nischal-backend.onrender.com/api/v1/sms/incoming'), // Replace with your API URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        print('Log data sent successfully.');
        print(response.body);
      } else {
        print('Failed to send log data. Status code: ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 16.0), // Adjust the font size as needed
        ),
      ),
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: _messages.isNotEmpty
              ? _MessagesListView(
            messages: _messages,
            sendLogToApi: _sendLogToApi,
          )
              : Center(
            child: Text(
              'No messages to show.\nTap the refresh button...',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var permission = await Permission.sms.status;
            if (permission.isGranted) {
              final messages = await _query.querySms(
                kinds: [
                  SmsQueryKind.inbox,
                  SmsQueryKind.sent,
                ],
                count: 10,
              );
              debugPrint('sms inbox messages: ${messages.length}');

              setState(() => _messages = messages);
            } else {
              await Permission.sms.request();
            }
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}

class _MessagesListView extends StatelessWidget {
  const _MessagesListView({
    Key? key,
    required this.messages,
    required this.sendLogToApi,
  }) : super(key: key);

  final List<SmsMessage> messages;
  final Function(String, String, String, String) sendLogToApi;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int i) {
        var message = messages[i];

        return ExpansionTile(
          title: Text('${message.sender} [${message.date}]'),
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('${message.body}'),
                  SizedBox(height: 10),
                  _SpamTypeButtons(sendLogToApi: sendLogToApi, smsMessage: message),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SpamTypeButtons extends StatefulWidget {
  final Function(String, String, String, String) sendLogToApi;
  final SmsMessage smsMessage;

  const _SpamTypeButtons({
    Key? key,
    required this.sendLogToApi,
    required this.smsMessage,
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
            widget.sendLogToApi(
              widget.smsMessage.sender ?? '',
              widget.smsMessage.address ?? '',
              widget.smsMessage.body ?? '',
              _selectedSpamType,
            );
          }
              : null,
          child: Text('Send Log to API'),
        ),

      ],
    );
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

