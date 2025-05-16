import 'dart:convert';
import 'package:college_app/model/user.dart';
import 'package:http/http.dart' as http;

class AuthService {

  static const String baseUrl = 'https://tc-ca-server.onrender.com/api/students/student';

  // 🔹 Register Student
  static Future<Map<String, dynamic>> registerStudent(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/register');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {
          "success": true,
          "message": data['message'],
          "token": data['token'],
          "student": Student.fromMap(data['data']),
        };
      } else {
        final data = jsonDecode(response.body);

        return {"success": false, "message": data['message']};
      }
    } catch (e) {

      return {"success": false, "message": e.toString()};
    }
  }

  // 🔹 Login Student
  static Future<Map<String, dynamic>> loginStudent(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return {
          "success": true,
          "message": data['message'],
          "token": data['token'],
          "student": Student.fromMap(data['data']),
        };
      } else {
        final data = jsonDecode(response.body);

        return {"success": false, "message": data['message']};
      }
    } catch (e) {

      return {"success": false, "message": e.toString()};
    }
  }

}