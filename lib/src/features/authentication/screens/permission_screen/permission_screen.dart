import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../login_screen/login_screen.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool agreedToTerms = false; // Initially not agreed

  static const LinearGradient bgradient = LinearGradient(
    colors: gradientColors,
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        systemNavigationBarColor: dialogueBoxColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          decoration: BoxDecoration(
            gradient: bgradient,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  permission, // Update with the image asset path
                  width: 196,
                  height: 173.97,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 16),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Terms and Conditions',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 8),

                      // Content
                      Text(
                        'Your privacy is our priority. We collect only essential data, and your personal data are protected!\n\n'
                            'How we work:\n'
                            'Nischal is a service of Foxintelligence. For the app to be free, we market data for statistical purposes on e-commerce. We do not transmit any data for advertising purposes, targeting, database, or profiling enrichment.\n\n'
                            'Your data is protected:\n'
                            'By using Nischal, you will never be targeted by advertisements, neither on our product nor afterwards.',
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 16),

                      // Agreement Checkbox
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: agreedToTerms,
                            onChanged: (value) {
                              setState(() {
                                agreedToTerms = value!;
                              });
                            },
                          ),
                          Text('I agree to the terms and conditions'),
                        ],
                      ),

                      SizedBox(height: 16), // Add some spacing for better visual separation

                      // Agree Button
                      ElevatedButton(
                        onPressed: agreedToTerms
                            ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        }
                            : null,
                        child: const Text(
                          'I Agree',
                          style: TextStyle(color: Colors.white70),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: agreedToTerms ? Color(0xFF1D4D4F) : Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
