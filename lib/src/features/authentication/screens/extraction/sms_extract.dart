import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class SMSScreen extends StatefulWidget {
  const SMSScreen({Key? key}) : super(key: key);

  @override
  State<SMSScreen> createState() => _SMSScreen();
}

class _SMSScreen extends State<SMSScreen> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];
  double _numericalValue = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMS Inbox ',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SMS Inbox Example'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: _messages.isNotEmpty
              ? _MessagesListView(
            messages: _messages,
          )
              : Center(
            child: Text(
              'No messages to show.\n Tap refresh button...',
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

              double numericalValue = await sendMessagesToAPI(messages);

              setState(() {
                _messages = messages;
                _numericalValue = numericalValue;
              });
            } else {
              await Permission.sms.request();
            }
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }

  Future<double> sendMessagesToAPI(List<SmsMessage> messages) async {
    List<Map<String, String>> messageList = [];
    for (var message in messages) {
      String date = '';
      if (message.date != null) {
        date = message.date!.toIso8601String();
      }

      String sender = '';
      if (message.sender != null) {
        sender = message.sender!;
      }

      String body = '';
      if (message.sender != null) {
        sender = message.sender!;
      }

      messageList.add({
        'sender': sender,
        'date': date,
        'body': body,
      });
    }


    final response = await http.post(
      Uri.parse('mann dharmesh acharya url'),
      body: {'messages': messageList.toString()},
    );


    if (response.statusCode == 200) {
      final numericalValue = double.parse(response.body);
      return numericalValue;
    } else {
      throw Exception('Failed bhai');
    }
  }
}

class _MessagesListView extends StatelessWidget {
  const _MessagesListView({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<SmsMessage> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int i) {
        var message = messages[i];

        return ListTile(
          title: Text('${message.sender} [${message.date}]'),
          subtitle: Text('${message.body}'),
        );
      },
    );
  }
}
