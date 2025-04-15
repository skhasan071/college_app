import 'package:college_app/constants/ui_helper.dart';
import 'package:college_app/view/college_predictor_page.dart';
import 'package:college_app/view/Filters&Compare/colleges.dart';
import 'package:college_app/view/drawer.dart';
import 'package:college_app/view/predicted_college.dart';
import 'package:college_app/view/profiles/complete_profile_page.dart';
import 'package:college_app/view/profiles/profile_page.dart';
import 'package:college_app/view/Filters&Compare/searchPage.dart';
import 'package:college_app/view/Filters&Compare/shortlistCollegePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../view_model/controller.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = Get.put(Controller());

  List<Widget> screens = [
    SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Colleges(),
    ),
    SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SelectionPage(),
    ),
    SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Text(
          "Insights",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
    ),
    SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CollegePredictorPage(),
    ),
    SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: ShortlistedCollegesPage(),
    ),
    SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: ProfilePage(),
    ),
    SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CollegeResultsPage(),
    ),
  ];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      backgroundColor: Colors.white,

      appBar: getAppBar(),

      body: Obx(() => screens[controller.navSelectedIndex.value]),

      drawer: DrawerWidget(),

      bottomNavigationBar: getBottomNavBar(),
    );
  }

  PreferredSizeWidget getAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(40),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 160,
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          scaffoldKey.currentState?.openDrawer();
                        },
                        icon: Icon(Icons.menu, color: Colors.black),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "TalentConnect",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 136,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.navSelectedIndex.value = 1;
                        },
                        icon: Icon(Icons.search, color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notifications, color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.navSelectedIndex.value = 5;
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getBottomNavBar() {
    return Container(
      width: double.infinity,
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black, width: 2)),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UiHelper.getNavItem(
              label: "Home",
              icon: Icons.home_outlined,
              callback: () {
                controller.navSelectedIndex.value = 0;
              },
              selected: controller.navSelectedIndex.value == 0,
            ),
            UiHelper.getNavItem(
              label: "Search",
              icon: Icons.search,
              callback: () {
                controller.navSelectedIndex.value = 1;
              },
              selected: controller.navSelectedIndex.value == 1,
            ),
            UiHelper.getNavItem(
              label: "Insights",
              icon: Icons.insights,
              callback: () {
                controller.navSelectedIndex.value = 2;
              },
              selected: controller.navSelectedIndex.value == 2,
            ),
            UiHelper.getNavItem(
              label: "Services",
              icon: Icons.design_services,
              callback: () {
                controller.navSelectedIndex.value = 3;
              },
              selected: controller.navSelectedIndex.value == 3,
            ),
            UiHelper.getNavItem(
              label: "Shortlist",
              icon: Icons.list,
              callback: () {
                controller.navSelectedIndex.value = 4;
              },
              selected: controller.navSelectedIndex.value == 4,
            ),
          ],
        ),
      ),
    );
  }
}
