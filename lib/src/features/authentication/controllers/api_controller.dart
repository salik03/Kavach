import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiController {
  final String baseUrl = 'https://605b-103-148-1-122.ngrok-free.app/api/v1/call/incoming';

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
  String calledName;
  String userAuthId;

  UserData({
    required this.calledPhoneNumber,
    required this.calledName,
    required this.userAuthId,
  });

  Map<String, dynamic> toJson() {
    return {
      'called_phone_number': calledPhoneNumber,
      'called_name': calledName,
      'user_auth_id': userAuthId,
    };
  }
}