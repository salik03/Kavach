import "package:flutter/material.dart";
import "package:kavach_2/src/features/authentication/screens/language/language_screen.dart";
import "package:kavach_2/src/features/authentication/screens/permission_screen/permission_screen.dart";
import "package:shared_preferences/shared_preferences.dart";
import "../../../../constants/image_strings.dart";
import "../dashboard_screen/dashboard_screen.dart";
import "../login_screen/login_screen.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0.0;
  @override
  void initState(){
    startAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,  // Adjust this value as needed to position the logo vertically
              child: AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(milliseconds: 1500),
                child: Image(image: AssetImage(logo)),
              ),
            ),
            Positioned(
              top: 450,  // Adjust this value to lower the tagline
              child: AnimatedOpacity(
                opacity: opacity,
                duration: Duration(milliseconds: 1500),
                child: Image(image: AssetImage(tagline)),
              ),
            ),
          ],
        ),
      ),
    );
  }




  Future startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() => opacity = 1.0);
    await Future.delayed(Duration(milliseconds: 5000));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUserId = prefs.getString('user_id');

    Widget initialScreen = storedUserId != null ? DashboardScreen() : LoginScreen();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => initialScreen));
  }
}
