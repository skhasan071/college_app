import 'package:college_app/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../services/apiservice.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  String sessionId;
  String fullName;
  OtpScreen(
      {required this.phone, required this.sessionId, required this.fullName});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with CodeAutoFill {
  String otpCode = "";
  int countdown = 60;
  late Timer _timer;
  bool isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    listenForCode();
  }

  void startTimer() {
    setState(() {
      countdown = 60;
      isResendEnabled = false;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        setState(() {
          isResendEnabled = true;
        });
        _timer.cancel();
      }
    });
  }

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code ?? ""; // Auto-fill OTP
    });
  }

  void resendOtp() async {
    if (!isResendEnabled) return;

    // Call API to resend OTP and get a new session ID
    String? newSessionId = await ApiService.sendOtp(widget.phone);

    if (newSessionId != null) {
      setState(() {
        widget.sessionId = newSessionId; // Update the session ID
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP Resent Successfully!")),
      );

      startTimer(); // Restart the timer
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
    cancel();
  }

  void verifyOtp() async {
    if (otpCode.length == 6) {
      bool isVerified = await ApiService.verifyOtp(widget.sessionId, otpCode);
      if (isVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("OTP Verified Successfully!")));

        var response =
        await ApiService.sendUserData(widget.fullName, widget.phone);

        print("API Response: $response");

        if (response != null && response.containsKey('token')) {
          String token = response['token'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage("")),
          );
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid OTP. Try again.")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter a valid 6-digit OTP")));
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
                'assets/otpscreen.jpg',
                height: 150,
              ),
              SizedBox(height: 20),

              // Title
              Text(
                "OTP Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // Subtitle with phone number
              Text(
                "Enter OTP sent to your mobile\n+91-${widget.phone.substring(0, 5)}-xxxxx",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 15),

              SizedBox(
                width: 300,
                child: PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  textStyle:
                  TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                  onChanged: (value) {
                    setState(() {
                      otpCode = value;
                    });
                  },
                  appContext: context,
                  controller: TextEditingController(text: otpCode), // Autofill
                ),
              ),
              SizedBox(height: 20),

              // Countdown Timer
              Text(
                countdown > 0
                    ? "Resend OTP in ${countdown}s"
                    : "Didn't receive OTP?",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 10),

              // Resend OTP Button
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

              // Continue Button
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