// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
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
//   InAppWebViewController _webViewController;
//
//   Future<String> checkUrlSafety(String url) async {
//     final response = await http.get('http://127.0.0.1:5000/check_url?a=$url' as Uri);
//
//     if (response.statusCode == 200) {
//       Map<String, dynamic> jsonResponse = json.decode(response.body);
//       return jsonResponse['response'];
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InAppWebView(
//       initialUrlRequest: URLRequest(url: Uri.parse('https://www.gmail.com')),
//       initialOptions: InAppWebViewGroupOptions(
//         crossPlatform: InAppWebViewOptions(
//           javaScriptEnabled: true,
//         ),
//       ),
//       onWebViewCreated: (InAppWebViewController controller) {
//         _webViewController = controller;
//       },
//       onLoadStop: (InAppWebViewController controller, Uri url) async {
//         String response = await checkUrlSafety(url.toString());
//
//         if (response == 'UNSAFE') {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text('Unsafe Website Warning'),
//                 content: Text('The website you are trying to access is marked as unsafe.'),
//                 actions: <Widget>[
//                   FlatButton(
//                     child: Text('OK'),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               );
//             },
//           );
//
//           // You can also decide to navigate away from the unsafe website using the _webViewController
//           // if (_webViewController != null) {
//           //   _webViewController.goBack();
//           // }
//         }
//       },
//     );
//   }
// }
