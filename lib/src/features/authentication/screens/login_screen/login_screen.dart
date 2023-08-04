// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:kavach_2/src/features/authentication/screens/login_screen/verify_screen.dart';
//
// import '../../../../constants/colors.dart';
// import '../../../../constants/image_strings.dart';
//
// class LoginScreen extends StatefulWidget {
//
//
//
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
//
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController _controller = TextEditingController();
//
//   static const LinearGradient bgradient = LinearGradient(
//       colors: gradientColors,
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter);
//   @override
//   Widget build(BuildContext context) {
//       SystemChrome.setSystemUIOverlayStyle(
//           const SystemUiOverlayStyle(
//             statusBarColor: primaryColor,
//             systemNavigationBarColor: dialogueBoxColor,
//             systemNavigationBarIconBrightness: Brightness.dark,
//           ));
//
//       return SafeArea(
//           child: Scaffold(
//           backgroundColor: Theme.of(context).backgroundColor,
//           appBar: AppBar(
//             title: Text('Phone Auth'),
//           ),
//           body: Container(
//             decoration: BoxDecoration(
//             gradient: bgradient,
//             image: backdrop,
//           ),
//             child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(children: [
//                 Container(
//                   margin: EdgeInsets.only(top: 60),
//                   child: Center(
//                     child: Text(
//                       'Phone Authentication',
//                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 40, right: 10, left: 10),
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Phone Number',
//                       prefix: Padding(
//                         padding: EdgeInsets.all(4),
//                         child: Text('+91'),
//                       ),
//                     ),
//                     maxLength: 10,
//                     keyboardType: TextInputType.number,
//                     controller: _controller,
//                   ),
//                 )
//               ]),
//               Container(
//                 margin: EdgeInsets.all(10),
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => VerifyScreen(_controller.text),
//                     ));
//                   },
//                   child: Text(
//                     'Next',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//           ),
//       );
//
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kavach_2/src/features/authentication/screens/login_screen/verify_screen.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();

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
        appBar: AppBar(
          title: Text('Phone Authentication'),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: bgradient,
            image: backdrop,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(login, // Replace with the appropriate image path for your design.
                width: 338,
                height: 380,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: dialogueBoxColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Login/Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Enter your Phone Number\n',
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 16),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 0, right: 10, left: 10),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              prefix: Padding(
                                padding: EdgeInsets.all(4),
                                child: Text('+91'),
                              ),
                            ),
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            controller: _controller,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VerifyScreen(_controller.text),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: buttonColor,
                        ),
                        child: const Text(
                          'Confirm',
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

