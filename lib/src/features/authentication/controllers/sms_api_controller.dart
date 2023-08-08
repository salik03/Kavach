import 'dart:convert';
import 'package:http/http.dart' as http;

class SmsApiController {
  final String baseUrl = 'https://nischal-backend.onrender.com/api/v1/sms/incoming';

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
  String phone_number_of_messenger;
  String called_name;
  String message_content;
  String user_auth_id;


  UserData({
    required this.phone_number_of_messenger,
    required this.called_name,
    required this.message_content,
    required this.user_auth_id,
  });

  Map<String, dynamic> toJson() {
    return {
      "phone_number_of_messenger": phone_number_of_messenger,
      "called_name": called_name,
      "message_content": message_content,
      "user_auth_id": user_auth_id
    };
  }
}