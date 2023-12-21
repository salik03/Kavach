import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kavach_2/src/constants/language_hardcode.dart';
import 'package:kavach_2/src/features/authentication/screens/dashboard_screen/dashboard_screen.dart';
import 'package:kavach_2/src/features/authentication/screens/language/language_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:kavach_2/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedUserId = prefs.getString('user_id');

  Widget initialScreen = storedUserId != null ? const DashboardScreen() : LanguageScreen();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    translations: LocalString(),
    locale: const Locale('en', 'US'),
    theme: TAppTheme.lightTheme,
    home: initialScreen,
  ));
}