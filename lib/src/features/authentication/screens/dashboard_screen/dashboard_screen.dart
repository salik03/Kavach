import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<AppInfo> _installedApps = [];

  @override
  void initState() {
    super.initState();
    getInstalledApps();
  }

  Future<void> getInstalledApps() async {
    List<AppInfo> apps = [];
    try {
      apps = await InstalledApps.getInstalledApps();
    } catch (e) {
      print('Error: $e');
    }

    setState(() {
      _installedApps = apps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Installed Apps'),
        ),
        body: ListView.builder(
          itemCount: _installedApps.length,
          itemBuilder: (context, index) {
            final app = _installedApps[index];
            return ListTile(
              leading: app.icon != null
                  ? Image.memory(
                app.icon!,
                width: 48,
                height: 48,
              )
                  : Icon(Icons.android),
              title: Text(app.packageName ?? 'Unknown App'),
              subtitle: Text(app.versionName ?? 'Unknown Version'),
            );
          },
        ),
      ),
    );
  }
}
