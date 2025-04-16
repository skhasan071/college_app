import 'package:college_app/view/FirstPage.dart';
import 'package:college_app/view/home_page.dart';
import 'package:college_app/view/login.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authEmailToken');

  runApp(DevicePreview(builder: (context)=>MyApp(token: token)));

}

class MyApp extends StatelessWidget {

  final String? token;

  const MyApp({this.token, super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
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