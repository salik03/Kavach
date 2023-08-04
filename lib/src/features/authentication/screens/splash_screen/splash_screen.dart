import "package:flutter/material.dart";
import "../../../../constants/image_strings.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Placeholder()
        ],
      ),
    );
  }
}
