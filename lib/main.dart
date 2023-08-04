import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kavach_2/src/constants/language_hardcode.dart';
import 'package:kavach_2/src/features/authentication/screens/permission_screen/permission_screen.dart';
import 'package:kavach_2/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'firebase_options.dart';
import 'package:kavach_2/src/features/authentication/screens/login_screen/login_screen.dart';
import 'package:kavach_2/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    translations: LocalString(),
    locale: Locale('en', 'US'),
    theme: TAppTheme.lightTheme,
    darkTheme: TAppTheme.darkTheme,
    themeMode: ThemeMode.system,
    home: MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return PermissionScreen();
  }
}

