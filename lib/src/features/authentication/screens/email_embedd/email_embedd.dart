// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
//
// class GmailWebViewScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GmailWebView(),
//     );
//   }
// }
//
// class GmailWebView extends StatefulWidget {
//   @override
//   _GmailWebViewState createState() => _GmailWebViewState();
// }
//
// class _GmailWebViewState extends State<GmailWebView> {
//   final FlutterWebviewPlugin _webviewPlugin = FlutterWebviewPlugin();
//
//   @override
//   void initState() {
//     super.initState();
//     _webviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
//       if (state.type == WebViewState.startLoad) {
//         print("URL changed: ${state.url as String}");
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WebviewScaffold(
//       url: 'https://www.gmail.com',
//     );
//   }
//
//   @override
//   void dispose() {
//     _webviewPlugin.dispose();
//     super.dispose();
//   }
// }
