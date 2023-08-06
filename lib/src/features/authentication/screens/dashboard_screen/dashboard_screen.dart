import 'package:flutter/material.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreen();
}

class _DashboardScreen
    extends State<DashboardScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
          // Add a BottomNavigationBarItem for your custom widget (index 3)
          BottomNavigationBarItem(
            icon: Icon(MyFlutterIcon.robot),
            label: 'Nischal',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class MyFlutterIcon {
  MyFlutterIcon._();

  static const _kFontFam = 'assets/icons/abot.ttf';
  static const String? _kFontPkg = null;

  static const IconData robot = IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
