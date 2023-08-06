import 'package:flutter/material.dart';

class NotificationOverlayExample extends StatefulWidget {
  const NotificationOverlayExample({super.key});

  @override
  State<NotificationOverlayExample> createState() =>
      _NotificationOverlayExampleState();
}

class _NotificationOverlayExampleState extends State<NotificationOverlayExample> {
  OverlayEntry? overlayEntry;

  // Function to create and show the notification overlay.
  void showNotificationOverlay(String notificationText, Color notificationColor) {
    // Remove the existing notification overlay.
    removeNotificationOverlay();

    assert(overlayEntry == null);

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: MediaQuery.of(context).size.height * 0.2,
          left: MediaQuery.of(context).size.width * 0.25,
          width: MediaQuery.of(context).size.width * 0.5,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              decoration: BoxDecoration(
                color: notificationColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                notificationText,
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
        );
      },
    );

    // Add the OverlayEntry to the Overlay.
    Overlay.of(context)!.insert(overlayEntry!);

    // Automatically remove the notification overlay after 3 seconds.
    Future.delayed(const Duration(seconds: 3), () {
      removeNotificationOverlay();
    });
  }

  // Remove the notification overlay.
  void removeNotificationOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Overlay Sample'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Simulate a notification coming.
            showNotificationOverlay('New Notification!', Colors.blue);
          },
          child: const Text('Show Notification'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotificationOverlayExample(),
  ));
}
