import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kavach_2/src/features/authentication/screens/dashboard_screen/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({Key? key}) : super(key: key);

  static const LinearGradient bgradient = LinearGradient(
    colors: gradientColors,
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  final List<Map<String, dynamic>> locale = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'हिन्दी', 'locale': const Locale('hi', 'IN')},
    {'name': 'ગુજરાતી', 'locale': const Locale('gu', 'IN')},
    {'name': 'తెలుగు', 'locale': const Locale('kn', 'IN')},
  ];

  void _updateLanguage(BuildContext context, Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_locale', locale.languageCode);

    Get.off(() => const DashboardScreen());
    Get.updateLocale(locale);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: bgradient,
          image: backdrop,
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: dialogueBoxColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'language'.tr,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final selected = Get.locale == locale[index]['locale'];
                    return GestureDetector(
                      onTap: () => _updateLanguage(
                        context,
                        locale[index]['locale'] as Locale,
                      ),
                      child: Container(
                        color: selected ? Colors.grey[200] : null,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          locale[index]['name'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: selected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
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
                    onPressed: () => Get.to(const DashboardScreen()), // Fix navigation
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                    ),
                    child: Text(
                      'confirm'.tr,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
