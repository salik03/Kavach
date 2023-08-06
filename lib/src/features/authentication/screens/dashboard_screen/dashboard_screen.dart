import 'package:flutter/material.dart';
import 'package:kavach_2/src/constants/colors.dart';
import 'package:flutter/services.dart';

import '../../models/icons.dart';
import '../language/language_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  // static const LinearGradient bgradient = LinearGradient(
  //   colors: gradientColors,
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  // );

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Calls',
      style: optionStyle,
    ),
    Text(
      'Messages',
      style: optionStyle,
    ),
    Text(
      'Mails',
      style: optionStyle,
    ),
    Center(
      child: Icon(MyFlutterIcon.robot, size: 100.0),
    ),
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
          },
          child: Icon(Icons.menu),
        ),
        actions: [
          GestureDetector(
            onTap: _navigateToLanguageScreen,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.language), // Replace 'Icons.language' with your desired icon
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
        decoration: BoxDecoration(
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: 'Calls',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_rounded),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: 'Mails',
            ),
            BottomNavigationBarItem(
              icon: Icon(MyFlutterIcon.robot),
              label: 'Nischal',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF1D4D4F),
          unselectedItemColor: Color(0xFFBEBEBE),
          selectedLabelStyle: TextStyle(color: Color(0xFF1D4D4F)),
          unselectedLabelStyle: TextStyle(color: Color(0xFFBEBEBE)),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
