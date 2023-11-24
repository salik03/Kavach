import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../dashboard_screen/dashboard_screen.dart';

class WebViewExample extends StatefulWidget {
  const WebViewExample({super.key});

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  final String initialUrl = 'https://mail.google.com';
  List<String> visitedLinks = [];

  // Function to handle URL loading and check if it's allowed
  Future<void> handleUrlLoading(InAppWebViewController controller, Uri? url) async {
    if (url != null && !url.toString().startsWith('https://mail.google.com')) {
      // Show a warning dialog before navigating to a different website
      bool continueNavigation = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Warning'),
            content: const Text('You are about to leave the Gmail website. Do you want to continue?'),
            actions: <Widget>[
              ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.push(
                      context,MaterialPageRoute(builder: (context) => const DashboardScreen(),
                  ))),
              ElevatedButton(
                child: const Text('Continue'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        },
      );

      if (continueNavigation) {
        // If user chooses to continue, load the URL
        controller.loadUrl(urlRequest: URLRequest(url: url));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
              onLoadStop: handleUrlLoading,
            ),
          ),
        ],
      ),
    );
  }
}

