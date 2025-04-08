import 'package:college_app/constants/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../view_model/controller.dart';

class HomePage extends StatefulWidget{
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text(""),
      ),
    );
  }
}