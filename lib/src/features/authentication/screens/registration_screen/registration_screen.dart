import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _acceptedTerms = false;
  bool _isButtonEnabled = false;

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  void _checkButtonEnabled() {
    bool enableButton = _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _acceptedTerms;

    setState(() {
      _isButtonEnabled = enableButton;
    });
  }

  void _createAccount() {
    // Implement your account creation logic here
    // This method will be called when the "Create an Account" button is pressed.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: dialogueBoxColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color with transparency
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.all(20),
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Almost There !',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  hintText: 'First Name',
                ),
                onChanged: (text) {
                  _checkButtonEnabled();
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  hintText: 'Last Name',
                ),
                onChanged: (text) {
                  _checkButtonEnabled();
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email ID (optional)',
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: _acceptedTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptedTerms = value!;
                        _checkButtonEnabled();
                      });
                    },
                  ),
                  Text('Accept the agreements'),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isButtonEnabled ? _createAccount : null,
                child: Text('Create an Account'),
                style: ElevatedButton.styleFrom(
                  primary: buttonColor,
                  onPrimary: _isButtonEnabled ? Colors.black : buttonColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
