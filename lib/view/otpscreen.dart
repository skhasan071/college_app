import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../services/otp_service.dart';
import 'home_page.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  OtpScreen({required this.phone});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpService otpService = OtpService();
  final TextEditingController otpController = TextEditingController();

  String otpCode = "";
  int countdown = 60;
  Timer? timer;
  bool isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    setState(() {
      countdown = 60;
      isResendEnabled = false;
    });

    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (countdown == 1) {
        t.cancel();
        setState(() => isResendEnabled = true);
      } else {
        setState(() => countdown--);
      }
    });
  }

  void verifyOtp() async {
    String otp = otpController.text.trim();

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter a valid 6-digit OTP")),
      );
      return;
    }

    bool success = await otpService.verifyOtp(widget.phone, otp);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP verified successfully")),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // replace with your home widget
            (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid or expired OTP")),
      );
    }
  }

  void resendOtp() async {
    bool sent = await otpService.sendOtp(widget.phone);
    if (sent) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP resent successfully")),
      );
      startCountdown(); // Restart timer
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to resend OTP")),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    otpController.dispose();
    super.dispose();
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
                'assets/otpscreen.jpg',
                height: 150,
              ),
              SizedBox(height: 20),

              Text(
                "OTP Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              Text(
                "Enter OTP sent to your mobile\n+91-${widget.phone.substring(3, 8)}-xxxxx",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 15),

              SizedBox(
                width: 300,
                child: PinCodeTextField(
                  length: 6,
                  controller: otpController,
                  onChanged: (value) => otpCode = value,
                  keyboardType: TextInputType.number,
                  textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    fieldHeight: 50,
                    fieldWidth: 40,
                    inactiveColor: Colors.black54,
                    activeColor: Colors.blue,
                    selectedColor: Colors.blueAccent,
                  ),
                  animationType: AnimationType.fade,
                  animationDuration: Duration(milliseconds: 200),
                  appContext: context,
                ),
              ),
              SizedBox(height: 20),

              Text(
                countdown > 0
                    ? "Resend OTP in ${countdown}s"
                    : "Didn't receive OTP?",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 10),

              TextButton(
                onPressed: isResendEnabled ? resendOtp : null,
                child: Text(
                  "Resend OTP",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isResendEnabled ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: verifyOtp,
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
