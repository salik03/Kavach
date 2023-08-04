
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';


final List locale = [
  {'name': 'English', 'locale': const Locale('en', 'US')},
  {'name': 'हिन्दी', 'locale': const Locale('hi', 'IN')},
  {'name': 'ગુજરાતી', 'locale': const Locale('gu', 'IN')},
  {'name': 'తెలుగు', 'locale': const Locale('te', 'IN')},
];

updatelanguage(Locale locale) {
  Get.back();
  Get.updateLocale(locale);
}

builddialog(BuildContext context) {
  showDialog(
    barrierColor: transparent,
    context: context,
    builder: (builder) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: dialogueBoxColor,
        title: Text(
          'language'.tr,
          textAlign: TextAlign.center,
        ),
        content: Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => updatelanguage(locale[index]['locale']),
                    child: Text(
                      locale[index]['name'],
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: dividerColor,
                  );
                },
                itemCount: locale.length,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  onPressed: () => null,
                  style: ElevatedButton.styleFrom(
                    primary: buttonColor,
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
