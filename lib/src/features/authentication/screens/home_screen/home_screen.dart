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
                      padding: const EdgeInsets.only(left: 20, bottom: 8, top: 110),
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
                childAspectRatio: 1.5,
                children: [
                  AlertBoxes(
                    alertText: 'Spam calls identified'.tr,
                    icon: Icons.warning,
                    alerts: 2,
                    color: Colors.white,
                    iconColor: Colors.red,
                  ),
                  AlertBoxes(
                    alertText: 'Messages moved to spam'.tr,
                    icon: Icons.do_disturb_on_rounded,
                    alerts: 2,
                    color: Colors.white,
                    iconColor: ocher,
                  ),
                  AlertBoxes(
                    alertText: 'Time saved from spammers'.tr,
                    icon: Icons.timer_sharp,
                    alerts: 2,
                    color: Colors.white,
                    iconColor: Colors.green,
                  ),
                  AlertBoxes(
                    alertText: 'Unkown numbers identified'.tr,
                    icon: Icons.search,
                    alerts: 2,
                    color: Colors.white,
                    iconColor: Colors.blue,
                  ),
                  AlertBoxes(
                    alertText: 'Verified callers identified'.tr,
                    icon: Icons.person_search,
                    alerts: 2,
                    color: Colors.white,
                    iconColor: iconColor,
                  ),
                  AlertBoxes(
                    alertText: 'Spam mails identified'.tr,
                    icon: Icons.mail_lock_sharp,
                    alerts: 2,
                    color: Colors.white,
                    iconColor: iconColor,
                  ),
                ],
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
                      color: cardColor,
                      icon: CupertinoIcons.phone_fill,
                      alertText: "Unresolved Phone Numbers".tr,
                      alerts: 2,
                      iconColor: Colors.red,
                    ),
                    AlertBoxes(
                      color: cardColor,
                      icon: CupertinoIcons.chat_bubble_fill,
                      alertText: "Unresolved messages".tr,
                      alerts: 42,
                      iconColor: Colors.red,
                    ),
                    AlertBoxes(
                      iconColor: Colors.red,
                      color: cardColor,
                      icon: CupertinoIcons.mail_solid,
                      alertText: "Unresolved Emails ".tr,
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
  final Color color;
  final Color iconColor;

  const AlertBoxes(
      {Key? key,
      required this.color,
      required this.icon,
      required this.alertText,
      required this.alerts,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: 130,
        height: 130,
        child: Card(
          color: color,
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
                      color: iconColor,
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
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
