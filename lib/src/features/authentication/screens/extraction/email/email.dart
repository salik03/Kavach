import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

GoogleSignIn _googleSignIn = GoogleSignIn.standard(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/gmail.readonly',
  ],
);



class GmailInboxScreen extends StatefulWidget {
  @override
  _GmailInboxScreenState createState() => _GmailInboxScreenState();
}

class _GmailInboxScreenState extends State<GmailInboxScreen> {
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
              return ListTile(
                title: Text(messages[index].snippet ?? ''),
              );
            },
          );
        } else {
          return Center(child: Text('No messages found.'));
        }
      },
    );
  }

  Future<List<gmail.Message>> _fetchInbox() async {
    final List<gmail.Message> messages = [];
    gmail.ListMessagesResponse listResponse = await _gmailApi!.users.messages.list("me");
    for (var message in listResponse.messages ?? []) {
      gmail.Message? fullMessage = await _gmailApi!.users.messages.get("me", message.id!);
      messages.add(fullMessage);
    }
    return messages;
  }
}
