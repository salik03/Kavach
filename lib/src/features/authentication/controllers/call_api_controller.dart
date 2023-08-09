import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApiController {
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
  String calledPhoneNumber;
  String calledDuration;
  String calledTimestamp;
  String calledIncontact;
  String calledType;
  String userAuthId;

  UserData({
    required this.calledPhoneNumber,
    required this.calledDuration,
    required this.calledTimestamp,
    required this.calledIncontact,
    required this.calledType,
    required this.userAuthId,
  });

  Map<String, dynamic> toJson() {
    return {
      "caller_phone_number": calledPhoneNumber,
      "call_duration": calledDuration,
      "call_timestamp": calledTimestamp,
      "caller_in_contact": calledIncontact,
      "call_type": calledType,
      "user_auth_id": userAuthId
    };
  }
}

class CallDataHandler {
  static Future<void> sendCallData(
      String phoneNumber,
      String duration,
      String timestamp,
      String inContact,
      String callType,
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUserId = prefs.getString('user_id');

    if (storedUserId != null) {
      UserData userData = UserData(
        calledPhoneNumber: phoneNumber,
        calledDuration: duration,
        calledTimestamp: timestamp,
        calledIncontact: inContact,
        calledType: callType,
        userAuthId: storedUserId,
      );

      CallApiController apiController = CallApiController();
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
