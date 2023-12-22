import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kavach_2/src/constants/language_hardcode.dart';
import 'package:kavach_2/src/features/authentication/screens/dashboard_screen/dashboard_screen.dart';
import 'package:kavach_2/src/features/authentication/screens/language/language_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kavach_2/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedLocale = prefs.getString('selected_locale');

  Locale initialLocale = savedLocale != null
      ? Locale(savedLocale)
      : const Locale('en', 'US');

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    translations: LocalString(),
    locale: initialLocale,
    theme: TAppTheme.lightTheme,
    home: savedLocale != null ? const DashboardScreen() : LanguageScreen(),
  ));
}

