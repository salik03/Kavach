import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SmsApiController {
  final String baseUrl = 'https://nischal-backend.onrender.com/api/v1/sms/incoming';

  Future<String> postSmsData(Map<String, dynamic> data) async {
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

class SmsData {
  String phoneNumberOfMessenger;
  String calledName;
  String messageContent;
  String userAuthId;

  SmsData({
    required this.phoneNumberOfMessenger,
    required this.calledName,
    required this.messageContent,
    required this.userAuthId,
  });

  Map<String, dynamic> toJson() {
    return {
      "phone_number_of_messenger": phoneNumberOfMessenger,
      "called_name": calledName,
      "message_content": messageContent,
      "user_auth_id": userAuthId,
    };
  }
}

class SmsDataHandler {
  static Future<void> sendSmsData(
      String messengerPhoneNumber,
      String calledName,
      String messageContent,
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUserId = prefs.getString('user_id');

    if (storedUserId != null) {
      SmsData smsData = SmsData(
        phoneNumberOfMessenger: messengerPhoneNumber,
        calledName: calledName,
        messageContent: messageContent,
        userAuthId: storedUserId,
      );

      SmsApiController apiController = SmsApiController();
      Map<String, dynamic> postData = smsData.toJson();

      try {
        await apiController.postSmsData(postData);
        print('SMS data sent successfully.');
      } catch (e) {
        print('Error sending SMS data: $e');
      }
    } else {
      print('User ID not found in SharedPreferences.');
    }
  }
}
