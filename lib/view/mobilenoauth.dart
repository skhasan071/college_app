import 'package:flutter/material.dart';
import '../services/apiservice.dart';
import 'otpscreen.dart';

class Mobilenoauth extends StatefulWidget {
  @override
  _MobilenoauthState createState() => _MobilenoauthState();
}

class _MobilenoauthState extends State<Mobilenoauth> {
  final TextEditingController phoneController = TextEditingController();

  void sendOtpAndNavigate() async {
    String phone = phoneController.text.trim();
    if (phone.length == 10) {
      String? sessionId = await ApiService.sendOtp(phone);
      if (sessionId != null) {
        // Navigate to OTP Screen with session ID
        var fullName="namrah";
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(
                phone: phone, sessionId: sessionId, fullName: fullName),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send OTP. Try again.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid 10-digit mobile number")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/otp_image.png',
                height: 150,
              ),
              SizedBox(height: 20),
              Text(
                "Login with a Mobile Number",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Enter your mobile number We will send you an OTP to verify.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      "+91",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                          hintText: "Enter mobile number",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: sendOtpAndNavigate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}