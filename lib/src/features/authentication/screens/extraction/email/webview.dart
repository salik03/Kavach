// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class AttachmentScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Attachment Example'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             final userId = 'uddinsalik03@gmail.com';
//             final messageId = '<CALC-u-L5LdNSwxH4WvA=LViPtRQ8p6-VVMSthpBM6YpwhwUPhw@mail.gmail.com>';
//             final attachmentId = '';
//             await fetchAttachment(userId, messageId);
//           },
//           child: Text('Fetch Attachment'),
//         ),
//       ),
//     );
//   }
// }
//
// Future<void> fetchAttachment(String userId, String messageId, String attachmentId) async {
//   final String apiUrl = 'https://gmail.googleapis.com/gmail/v1/users/$userId/messages/$messageId/attachments/$attachmentId';
//
//   final response = await http.get(
//     Uri.parse(apiUrl),
//     headers: {
//       'Authorization': 'AIzaSyCAd15IP9O4rBXXTmQ2qbWjWhaeiXoIWRo',
//     },
//   );
//
//   if (response.statusCode == 200) {
//     final attachmentData = response.body;
//
//     print('Attachment Data: $attachmentData');
//   } else {
//     print('Failed to fetch attachment. Status code: ${response.statusCode}');
//     print('Response body: ${response.body}');
//   }
// }
