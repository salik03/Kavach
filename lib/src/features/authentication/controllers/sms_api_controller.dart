import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class SmsApiController {
  final String baseUrl = 'https://nischal-backend.onrender.com/api/v1/call/incoming';

  Future<String> postCallData(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print('POST request successful.');
        return response.body;
      } else {
        print('Failed to make a POST request. Status code: ${response.statusCode}');
        throw Exception('Failed to make a POST request.');
      }
    } catch (e) {
      print('Error while making POST request: $e');
      throw e;
    }
  }
}

class UserData {
  String smsSender;
  String smsName;
  String smsContent;
  String smsSpamType;
  String user_id;

  UserData({
    required this.smsSender,
    required this.smsName,
    required this.smsContent,
    required this.smsSpamType,
    required this.user_id,
  });

  Map<String, dynamic> toJson() {
    return {
      "phone_number_of_messenger": smsSender,
      "called_name": smsName,
      "message_content": smsContent,
      "call_spam": smsSpamType,
      "user_auth_id": user_id
    };
  }
}

class CallDataHandler {
  static Future<void> sendCallData(
      String smsSender,
      String smsName,
      String smsContent,
      String smsSpamType,
      String user_id,
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUserId = prefs.getString('user_id');

    if (storedUserId != null) {
      UserData userData = UserData(
        smsSender: smsSender,
        smsName: smsName,
        smsContent: smsContent,
        smsSpamType: smsSpamType,
        user_id: user_id,
      );

      SmsApiController apiController = SmsApiController();
      Map<String, dynamic> postData = userData.toJson();

      try {
        await apiController.postCallData(postData);
        print('Call data sent successfully.');
      } catch (e) {
        print('Error sending call data: $e');
      }
    } else {
      print('User ID not found in SharedPreferences.');
    }
  }
}