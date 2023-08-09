import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kavach_2/src/features/authentication/screens/login_screen/verify_screen.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();
  bool _isPhoneNumberValid = false;

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
            // image: backdrop,
          ),
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Center(
                child: Image.asset(
                  login,
                  // width: 338,
                  // height: 380,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: dialogueBoxColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Login/Sign Up'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Enter your Phone Number'.tr,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 16),
                    Container(
                      margin: EdgeInsets.only(top: 0, right: 10, left: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Phone Number'.tr,
                          prefix: Padding(
                            padding: EdgeInsets.all(4),
                            child: Text('+91'),
                          ),
                        ),
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        controller: _controller,
                        onChanged: (value) {
                          setState(() {
                            _isPhoneNumberValid = value.length == 10;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isPhoneNumberValid
                            ? () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VerifyScreen(_controller.text),
                          ));
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          primary: buttonColor,
                        ),
                        child: Text(
                          'confirm'.tr,
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

