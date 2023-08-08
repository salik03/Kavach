import 'package:flutter/material.dart';

import 'features/authentication/controllers/api_controller.dart';

class TestingScreen extends StatefulWidget {
  @override
  _TestingScreenState createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  final ApiController controller = ApiController();
  String responseText = '';

  void _makePostRequest() async {
    try {
      UserData data = UserData(

        calledPhoneNumber: 'stringstrings',
        calledName: 'string',
        userAuthId: 'string',
      );

      String responseBody = await controller.postCallData(data.toJson());
      setState(() {
        responseText = responseBody;
      });
    } catch (e) {
      setState(() {
        responseText = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _makePostRequest,
              child: Text('Make POST Request'),
            ),
            SizedBox(height: 20),
            Text(responseText),
          ],
        ),
      ),
    );
  }
}

