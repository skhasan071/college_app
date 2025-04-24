import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String API_KEY = "9801c5aa-093e-11f0-8b17-0200cd936042";
  static const String baseUrl = "http://localhost:5000/api";
  // Function to send OTP
  static Future<String?> sendOtp(String mobileNumber) async {
    final Uri url = Uri.parse(
        "https://2factor.in/API/V1/$API_KEY/SMS/$mobileNumber/AUTOGEN/:otp-via-sms");

    final response = await http.get(url);

    final responseData = json.decode(response.body);
    if (responseData["Status"] == "Success") {
      return responseData["Details"];
    } else {
      return null;
    }
  }

  // Function to verify OTP
  static Future<bool> verifyOtp(String sessionId, String otp) async {
    final Uri url = Uri.parse(
        "https://2factor.in/API/V1/$API_KEY/SMS/VERIFY/$sessionId/$otp");

    final response = await http.get(url);

    final responseData = json.decode(response.body);
    return responseData["Status"] == "Success";
  }

  static Future<Map<String, dynamic>?> sendUserData(
      String fullName, String phone) async {
    final url = Uri.parse("$baseUrl/user");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"fullName": fullName, "phone": phone}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("Error sending user data: $e");
    }
    return null;
  }
}