import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kavach_2/src/features/authentication/screens/login_screen/login_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool allPermissionsGranted = false;

  Future<void> _requestLocationPermission() async {
    final PermissionStatus status = await Permission.location.request();
    _updateAllPermissionsGranted(status);
  }

  Future<void> _requestMessagePermission() async {
    final PermissionStatus status = await Permission.sms.request();
    _updateAllPermissionsGranted(status);
  }

  Future<void> _requestCallLogPermission() async {
    final PermissionStatus status = await Permission.phone.request();
    _updateAllPermissionsGranted(status);
  }

  Future<void> _requestNotificationPermission() async {
    final PermissionStatus status = await Permission.notification.request();
    _updateAllPermissionsGranted(status);
  }

  Future<void> _requestOverlayPermission() async {
    final PermissionStatus status = await Permission.systemAlertWindow.request();
    _updateAllPermissionsGranted(status);
  }

  void _updateAllPermissionsGranted(PermissionStatus status) async {
    final areAllPermissionsGranted =
        status.isGranted &&
            (await Permission.sms.status).isGranted &&
            (await Permission.phone.status).isGranted &&
            (await Permission.notification.status).isGranted &&
            (await Permission.systemAlertWindow.status).isGranted;

    setState(() {
      allPermissionsGranted = areAllPermissionsGranted;
    });
  }

  static const LinearGradient bgradient = LinearGradient(
    colors: gradientColors,
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        systemNavigationBarColor: dialogueBoxColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          decoration: BoxDecoration(
            gradient: bgradient,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                permission,
                width: 196,
                height: 173.97,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: dialogueBoxColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'App Permissions',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'We understand the nature and sensitivity of this topic and have taken strong measures to ensure that your data is not compromised.\n',
                      textAlign: TextAlign.center,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.location_city),
                      ),
                      onTap: () async {
                        await _requestLocationPermission();
                      },
                      title: Text("Device Location"),
                      subtitle:
                      Text("We need this permission to know single moms around you"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.notifications),
                      ),
                      onTap: () async {
                        await _requestNotificationPermission();
                      },
                      title: Text("Notifications"),
                      subtitle:
                      Text("We need this permission to tell you about single moms around you"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.call),
                      ),
                      onTap: () async {
                        await _requestCallLogPermission();
                      },
                      title: Text("Calls"),
                      subtitle:
                      Text("We need this permission to call single moms around you"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.message),
                      ),
                      onTap: () async {
                        await _requestMessagePermission();
                      },
                      title: Text("Messages"),
                      subtitle:
                      Text("We need this permission to message you about single moms around you"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.warning),
                      ),
                      onTap: () async {
                        await _requestOverlayPermission();
                      },
                      title: Text("Alert"),
                      subtitle:
                      Text("We need this permission to alert you about single moms around you"),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: allPermissionsGranted
                            ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        }
                            : null,
                        child: const Text(
                          'I Agree',
                          style: TextStyle(color: Colors.white70),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: allPermissionsGranted
                              ? Colors.white70: buttonColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
