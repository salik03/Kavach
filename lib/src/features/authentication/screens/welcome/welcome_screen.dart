import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../models/language/language_box.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static const LinearGradient bgradient = LinearGradient(
      colors: gradientColors,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      builddialog(context);
    });
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
            decoration: BoxDecoration(
              gradient: bgradient,
              image: backdrop,
            )));
  }
}
