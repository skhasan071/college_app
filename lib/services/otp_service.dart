import 'dart:convert';
import 'package:http/http.dart' as http;

class OtpService {
  final String baseUrl = 'https://tc-ca-server.onrender.com'; // <-- Using localhost:4000 directly

  /// Send OTP to the given phone number
  Future<bool> sendOtp(String phone) async {
    final url = Uri.parse('$baseUrl/send-otp');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        return true;
      } else {
        print('Send OTP failed: ${data['message']}');
        return false;
      }
    } catch (e) {
      print('Error sending OTP: $e');
      return false;
    }
  }

  /// Verify the OTP for the given phone number
  Future<bool> verifyOtp(String phone, String otp) async {
    final url = Uri.parse('$baseUrl/verify-otp');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone, 'otp': otp}),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        return true;
      } else {
        print('OTP verification failed: ${data['message']}');
        return false;
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      return false;
    }
  }
}
