import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kavach_2/src/constants/image_strings.dart';

class SplashScreenController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed('/home');
    });
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (controller) => const Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 180,
                left: 15,
                child: Image(
                  image: AssetImage(tSplashTopIcon),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}