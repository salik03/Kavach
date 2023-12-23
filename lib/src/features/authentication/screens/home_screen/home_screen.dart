import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kavach_2/src/constants/colors.dart';
import 'package:kavach_2/src/constants/image_strings.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.asset(banner),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, bottom: 8, top: 110),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Chat now".tr),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Recents".tr,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black87),
                borderRadius: BorderRadius.circular(22),
              ),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 2,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(0),
                children: List.generate(
                  6,
                  (index) => const Card(
                      shape: Border(), child: Center(child: Text(""))),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Alerts".tr,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
              height: 150,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 10),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    AlertBoxes(
                      icon: CupertinoIcons.phone_fill,
                      alertText: "Unresolved Phone Numbers".tr,
                      alerts: 2,
                    ),
                    AlertBoxes(
                      icon: CupertinoIcons.chat_bubble_fill,
                      alertText: "Unresolved messages".tr,
                      alerts: 42,
                    ),
                    AlertBoxes(
                      icon: CupertinoIcons.mail_solid,
                      alertText: "Unresolved Emails".tr,
                      alerts: 21,
                    )
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}

class AlertBoxes extends StatelessWidget {
  final IconData icon; // New required parameter for the icon
  final String alertText; // New required parameter for the alert text
  final int alerts;

  const AlertBoxes(
      {Key? key,
      required this.icon,
      required this.alertText,
      required this.alerts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: 130,
        height: 130,
        child: Card(
          color: cardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 14),
                    child: Icon(
                      icon, // Use the provided icon
                      size: 50,
                      color: Colors.red,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                    child: Text(
                      alerts.toString(), // Use the provided alert text
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: cardTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  alertText,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
