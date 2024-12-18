import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterService {
  final String _baseUrl = "https://backend-o7xm.onrender.com/auth/register";

  // A function to send a POST request and return the response as a map
  Future<Map<String, dynamic>> registerUser(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 201) {
        // Successful registration
        return _parseResponse(response.body); // Return parsed response as a map
      } else {
        // Registration failed
        return {
          'success': false,
          'message': 'Failed to register',
          'data': response.body
        };
      }
    } catch (error) {
      print('Error: $error');
      return {
        'success': false,
        'message': 'Error occurred',
        'data': error.toString()
      };
    }
  }

  // A helper function to parse the JSON response into a Map
  Map<String, dynamic> _parseResponse(String responseBody) {
    return json.decode(responseBody);
  }
}
