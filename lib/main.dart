import 'package:college_app/model/admission_process.dart';
import 'package:college_app/view/FirstPage.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DevicePreview(builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: Firstpage());
  }
}

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("All The Best Guyz")));
  }
}
