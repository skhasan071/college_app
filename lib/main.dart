import 'package:college_app/view/SignUpLogin/FirstPage.dart';
import 'package:college_app/view/home_page.dart';
import 'package:college_app/view_model/themeController.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  Get.put(ThemeController());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    DevicePreview(builder: (context)=>MyApp())
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
       home: token == null || token == "" ? Firstpage() : HomePage(token!),
    );
  }

  Future<void> loadToken() async {
    token = await getToken();
    setState(() {});
  }
}

// Function to get the token
Future<String?> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token'); // Will return null if no token is saved
}

// Function to save the token
Future<void> delToken(String token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('auth_token', token);
}

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("All The Best Guyz")));
  }
}
