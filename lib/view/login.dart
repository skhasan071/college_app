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
  final GoogleSignInApi _googleAuthService = GoogleSignInApi();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  void _handleLogin() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      Navigator.pushReplacement(context, MaterialPageRoute (
          builder: (context) =>  HomePage()),
      );
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
                  bool isLogged = await login(); // Calling signIn method properly with async
                  if (isLogged) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage())
                    );
                  }
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
  Future signIn() async {
    final user = await GoogleSignInApi.login();

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signin Failed")),
      );
      print("Signin failed");
    } else {
      // Get ID token for web
      final auth = await user.authentication;
      final idToken = auth.idToken;

      // Print the ID token for debugging
      print("ID Token: $idToken");

      // Get the email from the signed-in user
      final String email = user.email;

      // Send email and ID token to the backend
      final response = await http.post(
        Uri.parse("http://localhost:4000/auth/google-auth"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "idToken": idToken,
        }),
      );

      if (response.statusCode == 200) {
        print("Successful");
        final data = jsonDecode(response.body);

        // Check if user needs to be redirected
        // Navigate to the Dashboard page
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
        }
       else {
        print(jsonDecode(response.body));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error checking user")),
        );
      }
    }
  }

  Future<bool> login() async {
    final user = await GoogleSignIn().signIn();  // Signing in with Google
    GoogleSignInAuthentication userAuth = await user!.authentication;  // Getting the authentication details
    print("ID Token: ${userAuth.idToken}");
    var credential = GoogleAuthProvider.credential(  // Creating credentials using the idToken and accessToken
      idToken: userAuth.idToken,
      accessToken: userAuth.accessToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);  // Signing into Firebase using the credentials
    return FirebaseAuth.instance.currentUser != null;  // Returns true if the user is logged in, else false

  }

// Future signIn() async {
  //   final user = await GoogleSignInApi.login();
  //
  //   if (user == null) {
  //
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signin Failed")));
  //     print("failed");
  //   } else {
  //     // Get the email from the signed-in user
  //     final String email = user.email;
  //
  //
  //
  //     // Send the email to the backend to check if it's already in the database
  //     final response = await http.post(
  //       Uri.parse("http://localhost:4000/auth/google-auth"),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode({"email":email}),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print("Successful");
  //       final data = jsonDecode(response.body);
  //
  //       // Check the backend response to see if the user should be redirected
  //       if (data['redirect']) {
  //         // If redirect is true, it means the user does not exist
  //         print("Redirecting to Dashboard (new user)");
  //
  //         // Navigate to the Dashboard page for new user
  //         Navigator.of(context).pushReplacement(
  //             MaterialPageRoute(builder: (context) => HomePage()) // Replace with actual Dashboard page
  //         );
  //       }
  //     } else {
  //       print(jsonDecode(response.body));
  //       // If the server returns an error
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text("Error checking user"))
  //
  //  );
  //     }
  //   }   }

}
