import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../extraction/apiintegration/callapi.dart';
import '../extraction/sms_extract.dart';
import '../home_screen/home_screen.dart';
import '../language/language_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  set index(int index) => _selectedIndex = index;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // Add the SMSScreen widget to the list of widget options
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(), // Home Placeholder
    const PhonelogsScreenApi(),
    const SMSScreen(), // Mails Placeholder
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToLanguageScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LanguageScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            // Handle menu icon tap here
          },
          child: const Icon(Icons.menu),
        ),
        actions: [
          GestureDetector(
            onTap: _navigateToLanguageScreen,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons
                  .language), // Replace 'Icons.language' with your desired icon
            ),
          ),
        ],
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: bgradient,
        // ),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: Container(
        decoration:  const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.grey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.call),
              label: 'calls'.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.message_rounded),
              label: 'messages'.tr,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF1D4D4F),
          unselectedItemColor: const Color(0xFFBEBEBE),
          selectedLabelStyle: const TextStyle(color: Color(0xFF1D4D4F)),
          unselectedLabelStyle: const TextStyle(color: Color(0xFFBEBEBE)),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
