import 'package:college_app/view/blog_detail_page.dart';
import 'package:college_app/view/blog_page.dart';
import 'package:college_app/view/login.dart';
import 'package:college_app/view/profiles/complete_profile_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    DevicePreview(builder: (context)=>MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class TestingPage extends StatelessWidget{
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("All The Best Guyz"),
      ),
    );
  }
}