import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';


class GmailInboxScreen extends StatefulWidget {
  @override
  _GmailInboxScreenState createState() => _GmailInboxScreenState();
}

class _GmailInboxScreenState extends State<GmailInboxScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn.standard(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/gmail.readonly',
    ],
  );

  GoogleSignInAccount? _currentUser;
  gmail.GmailApi? _gmailApi;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
        if (_currentUser != null) {
          _initializeGmailApi();
        }
      });
    });
    _googleSignIn.signInSilently();
  }

  void _initializeGmailApi() async {
    var httpClient = (await _googleSignIn.authenticatedClient())!;
    _gmailApi = gmail.GmailApi(httpClient);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _googleSignIn.signIn();
            },
            child: Text('Sign in with Google'),
          ),
        ),
      );
    } else if (_gmailApi == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Gmail Inbox'),
        ),
        body: _buildInbox(),
      );
    }
  }

  Widget _buildInbox() {
    return FutureBuilder<List<gmail.Message>>(
      future: _fetchInbox(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final messages = snapshot.data!;
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final sender = _getSenderEmail(message);
              final subject = _getSubject(message);

              return ListTile(
                title: Text(subject),
                subtitle: Text(sender),
                onTap: () {
                  _showEmailDetails(message);
                },
              );
            },
          );
        } else {
          return Center(child: Text('No messages found.'));
        }
      },
    );
  }

  String _getSenderEmail(gmail.Message message) {
    final headers = message.payload?.headers;
    if (headers != null) {
      for (final header in headers) {
        if (header.name == 'From') {
          return header.value ?? 'Unknown';
        }
      }
    }
    return 'Unknown';
  }

  String _getSubject(gmail.Message message) {
    final headers = message.payload?.headers;
    if (headers != null) {
      for (final header in headers) {
        if (header.name == 'Subject') {
          return header.value ?? 'No Subject';
        }
      }
    }
    return 'No Subject';
  }

  Future<List<gmail.Message>> _fetchInbox() async {
    final List<gmail.Message> messages = [];

    gmail.ListMessagesResponse listResponse = await _gmailApi!.users.messages.list("me");
    List<gmail.Message> messageList = listResponse.messages ?? [];

    // Fetch the first 15 messages or fewer if the list is smaller
    int messagesToFetch = messageList.length > 15 ? 15 : messageList.length;

    for (int i = 0; i < messagesToFetch; i++) {
      gmail.Message? fullMessage = await _gmailApi!.users.messages.get("me", messageList[i].id!);
      messages.add(fullMessage!);
    }

    return messages;
  }

  void _showEmailDetails(gmail.Message email) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('From: ${_getSenderEmail(email)}'),
              SizedBox(height: 8),
              Text('Message:'),
              SizedBox(height: 4),
              Text(email.snippet ?? ''),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
