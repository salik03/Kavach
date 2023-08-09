import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kavach_2/src/constants/language_hardcode.dart';
import 'package:kavach_2/src/features/authentication/controllers/call_api_controller.dart';
import 'package:kavach_2/src/features/authentication/screens/dashboard_screen/dashboard_screen.dart';
import 'package:kavach_2/src/features/authentication/screens/email_embedd/email_embedd.dart';
import 'package:kavach_2/src/features/authentication/screens/extraction/apiintegration/smsapi.dart';
import 'package:kavach_2/src/features/authentication/screens/extraction/call_logs.dart';
import 'package:kavach_2/src/features/authentication/screens/extraction/sms_extract.dart';
import 'package:kavach_2/src/features/authentication/screens/language/language_screen.dart';
import 'package:kavach_2/src/features/authentication/screens/login_screen/verify_screen.dart';
import 'package:kavach_2/src/features/authentication/screens/overlay.dart';
import 'package:kavach_2/src/features/authentication/screens/permission_screen/permission_screen.dart';
import 'package:kavach_2/src/features/authentication/screens/registration_screen/registration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:kavach_2/src/features/authentication/screens/login_screen/login_screen.dart';
import 'package:kavach_2/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedUserId = prefs.getString('user_id');

  Widget initialScreen = storedUserId != null ? DashboardScreen() : LoginScreen();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    translations: LocalString(),
    locale: Locale('en', 'US'),
    theme: TAppTheme.lightTheme,
    home: initialScreen,
  ));
}

