import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kavach_2/src/features/authentication/screens/registration_screen/registration_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/colors.dart';

class VerifyScreen extends StatefulWidget {
  final String phone;
  const VerifyScreen(this.phone, {super.key});

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  bool _isConfirmButtonEnabled = false;
  String? _userId;

  static const LinearGradient bgradient = LinearGradient(
    colors: gradientColors,
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.black),
      // borderRadius: BorderRadius.circular(20),
    ),
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
        backgroundColor: Theme.of(context).colorScheme.background,
        key: _scaffoldkey,
        body: Container(
          decoration: const BoxDecoration(
            gradient: bgradient,
            // image: backdrop,
          ),
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: dialogueBoxColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        'Verify +91-${widget.phone}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Pinput(
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      controller: _pinPutController,
                      pinAnimationType: PinAnimationType.fade,
                      onCompleted: (pin) {
                        setState(() {
                          _isConfirmButtonEnabled = true;
                        });
                      },
                      onChanged: (pin) {
                        setState(() {
                          _isConfirmButtonEnabled = false;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _isConfirmButtonEnabled ? _onConfirmButtonPressed : null,
                    child: const Text('Confirm'),
                  ),
                  ElevatedButton(
                    onPressed: _onEditNumberButtonPressed,
                    child: const Text('Edit Number'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }

  void _onConfirmButtonPressed() async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(verificationId: _verificationCode!, smsCode: _pinPutController.text))
          .then((value) async {
        if (value.user != null) {
          setState(() {
            _userId = value.user!.uid;
          });

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('user_id', _userId!);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                (route) => false,
          );
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }


  void _onEditNumberButtonPressed() {
    Navigator.pop(context);
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                      (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 120));
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }
}