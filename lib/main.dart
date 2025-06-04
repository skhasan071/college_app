import 'package:college_app/services/shortListCollegeController.dart';
import 'package:college_app/view/SignUpLogin/FirstPage.dart';
import 'package:college_app/view/home_page.dart';
import 'package:college_app/view_model/themeController.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  Get.put(ThemeController());
  Get.put(ShortlistedCollegesController());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    //DevicePreview(builder: (context)=>MyApp())
    MyApp()
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
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.black),
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontFamilyFallback: ['NotoSans']),
        ),
      ),
       home: token == "" ? Firstpage() : HomePage(token!),
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