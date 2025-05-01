import 'package:college_app/constants/card.dart';
import 'package:college_app/model/college.dart';
import 'package:college_app/view_model/controller.dart';
import 'package:college_app/view_model/profile_controller.dart';
import 'package:college_app/view_model/themeController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SearchRes extends StatelessWidget {
  List<College> colleges = [];

  SearchRes(this.colleges, {super.key});

  ProfileController controller = Get.find<ProfileController>();
  Controller ctrl = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final theme = ThemeController.to.currentTheme;
      return Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          title: Text(
            "Search",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          backgroundColor: theme.filterSelectedColor,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),

        body:
            colleges.isNotEmpty
                ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: colleges.length,
                    itemBuilder: (context, index) {
                      College clg = colleges[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 15,
                        ),
                        child: CardStructure(
                          clg: clg,
                          collegeID: clg.id,
                          collegeName: clg.name,
                          coursesCount: 0,
                          feeRange: 12000.toString(),
                          state: clg.state,
                          ranking: clg.ranking.toString(),
                          studId:
                              ctrl.isGuestIn.value
                                  ? "Nothing"
                                  : controller.profile.value!.id,
                          clgId: clg.id,
                        ),
                      );
                    },
                  ),
                )
                : Center(
                  child: Text(
                    "No Colleges Found",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
      );
    });
  }
}
