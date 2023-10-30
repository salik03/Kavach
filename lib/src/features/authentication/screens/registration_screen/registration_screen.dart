import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kavach_2/src/features/authentication/screens/dashboard_screen/dashboard_screen.dart';
import '../../../../constants/colors.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});



  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationScreen> {
  bool _acceptedTerms = false;
  bool _isButtonEnabled = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _checkButtonEnabled() {
    bool enableButton = _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _acceptedTerms;

    setState(() {
      _isButtonEnabled = enableButton;
    });
  }

  void _createAccount() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Use the user's UID as the document ID in Firestore
      final userDocRef = FirebaseFirestore.instance.collection('Users').doc(user.uid);

      // Create a map of user data to save
      final userData = {
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
        'email': _emailController.text,
        // Add other fields as needed
      };

      // Save user data to Firestore
      await userDocRef.set(userData);

      // Navigate to the dashboard screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Page'),
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
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Almost There !',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  hintText: 'First Name',
                ),
                onChanged: (text) {
                  _checkButtonEnabled();
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  hintText: 'Last Name',
                ),
                onChanged: (text) {
                  _checkButtonEnabled();
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email ID (optional)',
                ),
              ),
              const SizedBox(height: 10),
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
                  const Text('Accept the agreements'),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isButtonEnabled ? _createAccount : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: _isButtonEnabled ? Colors.black : buttonColor, backgroundColor: buttonColor,
                ),
                child: const Text('Create an Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
