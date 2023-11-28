import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class SMSScreen extends StatefulWidget {
  const SMSScreen({Key? key}) : super(key: key);

  @override
  State<SMSScreen> createState() => _MyAppState();
}

class _MyAppState extends State<SMSScreen> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: const TextTheme(
          titleLarge:
              TextStyle(fontSize: 16.0), // Adjust the font size as needed
        ),
      ),
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: _messages.isNotEmpty
              ? _MessagesListView(
                  messages: _messages,
                )
              : Center(
                  child: Text(
                    'No messages to show.\nTap the refresh button...',
                    style: Theme.of(context).textTheme.titleLarge,
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
  }) : super(key: key);

  final List<SmsMessage> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int i) {
        var message = messages[i];

        return FutureBuilder<String>(
          future: sendRequest(message.body!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Placeholder for loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var spam = snapshot.data;
              return ExpansionTile(
                title: Text(
                  '${message.sender} [${message.date}] $spam',
                  style: TextStyle(
                      color: spam.toString() == "Spam"
                          ? Colors.red
                          : Colors.green),
                ),
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('${message.body}'),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }
}

Future<String> sendRequest(String message) async {
  var url =
      Uri.parse('https://nischal-backend.onrender.com/api/v1/sms/incoming');

  var spam = {
    "phone_number_of_messenger": "1234567890123",
    "called_name": "string",
    "message_content": message,
    "call_spam": "s",
    "user_auth_id": "string"
  };

  try {
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(spam),
    );

    if (response.statusCode == 200) {
      // Parse the response body as a map
      Map<String, dynamic> responseBody = json.decode(response.body);

      // Check if the map is not empty
      if (responseBody.isNotEmpty) {
        // Get the first key and its corresponding value
        String firstKey = responseBody.keys.first;
        dynamic firstValue = responseBody[firstKey];

        // Return a string containing the first key-value pair
        return '$firstValue';
      } else {
        // Return an error message if the map is empty
        return 'Error: Empty response body';
      }
    } else {
      // Return an error message if the request fails
      return 'Error: ${response.statusCode}, Response: ${response.body}';
    }
  } catch (error) {
    // Return an error message for other types of errors
    return 'Error: $error';
  }
}
