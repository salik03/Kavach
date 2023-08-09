import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SmsApiController {
  final String baseUrl = 'https://nischal-backend.onrender.com/api/v1/sms/incoming';

  Future<Map<String, dynamic>> postSmsData(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print('POST request successful.');
        return json.decode(response.body);
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

class SMSScreenApi extends StatefulWidget {
  const SMSScreenApi({Key? key}) : super(key: key);

  @override
  State<SMSScreenApi> createState() => _MyAppState();
}

class _MyAppState extends State<SMSScreenApi> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];
  String? storedUserId;

  @override
  void initState() {
    super.initState();
    // Load user_auth_id from SharedPreferences
    loadUserId();
  }

  Future<void> loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    storedUserId = prefs.getString('user_id');
  }

  Future<void> sendSmsData(SmsMessage message) async {
    if (storedUserId != null) {
      SmsApiController apiController = SmsApiController();

      Map<String, dynamic> smsData = {
        "phone_number_of_messenger": message.sender,
        "called_name": "Some Called Name", // Replace with your data
        "message_content": message.body,
        "user_auth_id": storedUserId,
      };

      try {
        Map<String, dynamic> response = await apiController.postSmsData(smsData);
        print('SMS data sent successfully. Response: $response');

        // Store the response in local storage using SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('sms_response_${message.id}', json.encode(response));
        print('Response stored in local storage.');
      } catch (e) {
        print('Error sending SMS data: $e');
      }
    } else {
      print('User ID not found in SharedPreferences.');
    }
  }

  Future<void> fetchSmsData() async {
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      final messages = await _query.querySms(
        kinds: [
          SmsQueryKind.inbox,
          SmsQueryKind.sent,
        ],
        count: 10,
      );

      setState(() => _messages = messages);
      print('Fetched ${messages.length} SMS messages.');

      for (var message in messages) {
        await sendSmsData(message);
      }
    } else {
      await Permission.sms.request();
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
          onPressed: fetchSmsData,
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

  Future<Map<String, dynamic>?> _getResponseFromSharedPreferences(String messageId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? responseJson = prefs.getString('sms_response_$messageId');

    if (responseJson != null) {
      return json.decode(responseJson);
    }
    return null; // Handle case when responseJson is null
  }

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
            FutureBuilder<Map<String, dynamic>?>(
              future: _getResponseFromSharedPreferences("${message.id}"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final responseMap = snapshot.data!;
                  final spamStatus = responseMap['spamStaus'] ?? '';
                  final spamScore = responseMap['spamScore'] ?? '';

                  Color backgroundColor = Colors.grey;

                  if (spamStatus.toLowerCase() == 'spam') {
                    backgroundColor = Colors.red;
                  } else {
                    backgroundColor = Colors.green;
                  }

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: backgroundColor,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${message.body}',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        if (spamScore != null)
                          Text(
                            'Spam Score: $spamScore',
                            style: TextStyle(color: Colors.white),
                          ),
                      ],
                    ),
                  );
                } else {
                  return Text('No data available.');
                }
              },
            ),
          ],
        );
      },
    );
  }
}

