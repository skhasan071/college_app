import 'package:college_app/services/auth_services.dart';
import 'package:college_app/view/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../services/google_signin_api.dart';
import 'emailverification.dart';
import 'home_page.dart';
import 'mobilenoauth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  Future<void> _handleLogin() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {

      Map<String, dynamic> map = await AuthService.loginStudent(email, password);

      if(map["success"]){

        String token = map['token'];

        print("Token =============== $token");

        await saveToken(token);

        Navigator.pushReplacement(context, MaterialPageRoute (
            builder: (context) =>  HomePage(token)),
        );

      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(map["message"]),
            backgroundColor: Colors.purple,
            duration: Duration(seconds: 2),
          ),
        );
      }

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in both fields"),
          backgroundColor: Colors.purple,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: RichText(
                    text: TextSpan(
                        text: "Log In",
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)))),

            const SizedBox(height: 10),
            Center(
                child: RichText(
                    text: TextSpan(
                        text: "Login here to continue to app",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100)))),

            const SizedBox(height: 50),
            const Text(
              "Email",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Password",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: passwordController,
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmailVerification()),
                  );
                },
                child: const Text(
                  "Forgot Password ?",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      decoration: TextDecoration.underline
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2)),
                ),
                onPressed: _handleLogin,
                child: const Text("Login",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                    side: const BorderSide(color: Colors.black),
                  ),
                  elevation: 2,
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  Mobilenoauth()),
                  );

                },
                icon: Image.asset(
                  'assets/gmail-logo.jpg',
                  height: 43,
                  width: 43,
                ),
                label: const Text(
                  "Log in with Mobile Number",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                    side: const BorderSide(color: Colors.black),
                  ),
                  elevation: 2,
                ),
                onPressed: () async {
                  signIn2();

                  // bool isLogged = await login(); // Calling signIn method properly with async
                  // if (isLogged) {
                  //   print("hello");
                  //   Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => HomePage())
                  //   );
                  // }
                },
                icon: Image.asset(
                  'assets/gmail-logo.jpg',
                  height: 43,
                  width: 43,
                ),
                label: const Text(
                  "Log in with Gmail",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 25),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Sign up",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupPage()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future signIn() async {
  //   final user = await GoogleSignInApi.login();
  //
  //   if (user == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signin Failed")));
  //     print("Signin failed");
  //   } else {
  //     // Get the email from the signed-in user
  //     final String email = user.email;
  //
  //     // Send the email to the backend to check if it's already in the database
  //     final response = await http.post(
  //       Uri.parse("http://localhost:4000/auth/google-auth"),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({"email": email}),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print("Signin successful");
  //       final data = jsonDecode(response.body);
  //
  //       // Check the backend response to see if the user exists or not
  //       if (data['redirect']) {
  //         // If redirect is true, it means the user is new or authenticated
  //         Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(builder: (context) => HomePage("")), // Redirect to HomePage (Dashboard)
  //         );
  //       }
  //     } else {
  //       print(jsonDecode(response.body));
  //       // If the server returns an error
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error checking user")));
  //     }
  //   }
  // }

  Future signIn2() async {
    try {
      // Sign in with Google
      final user = await GoogleSignIn().signIn();

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signin Failed")));
        return;
      }

      // Get the Google SignIn authentication
      final GoogleSignInAuthentication authentication = await user.authentication;

      // Send the access token to the backend for verification
      final response = await http.post(
        Uri.parse("http://localhost:8080/auth/google-auth"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": user.email, "name":user.displayName}),
      );

      if (response.statusCode == 200) {
        print("Signin successful");
        final data = jsonDecode(response.body);
        if (data['redirect']) {
          print(data['token']);
          await saveToken(data['token']);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage(data['token'])),
          );
        }
      } else {
        print(jsonDecode(response.body));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error checking user")));
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error during sign-in")));
    }
  }

  // Function to save the token
  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

}
