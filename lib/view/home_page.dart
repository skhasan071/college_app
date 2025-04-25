import 'package:college_app/constants/ui_helper.dart';
import 'package:college_app/model/user.dart';
import 'package:college_app/services/user_services.dart';
import 'package:college_app/view/blog_page.dart';
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
import '../view_model/profile_controller.dart';

class HomePage extends StatefulWidget {

  String token;

  HomePage(this.token,{super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  var controller = Get.put(Controller());
  var profileController = Get.put(ProfileController());

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
      child: BlogPage(),
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

  @override
  void initState() {
    super.initState();
    widget.token != "" ? getUser() : controller.isGuestIn(true);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      backgroundColor: Colors.white,

      appBar: getAppBar(),

      body: Obx(() => controller.isLoggedIn.value || controller.isGuestIn.value? screens[controller.navSelectedIndex.value] : Center(child: CircularProgressIndicator())),

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
                          if(controller.isGuestIn.value){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please Login First"),
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.black,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }else{
                            controller.navSelectedIndex.value = 5;
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: Colors.black, width: 2)
                          ),
                          child: Center(child: Text(profileController.profile.value == null ? "?" : profileController.profile.value!.name[0].toUpperCase(), style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black, fontSize: 16),)),
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
                if(controller.isGuestIn.value){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please Login First"),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.black,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }else{
                  controller.navSelectedIndex.value = 4;
                }
              },
              selected: controller.navSelectedIndex.value == 4,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getUser() async {
    print(widget.token);
    Student? student = await StudentService().getStudent(widget.token);
    profileController.profile.value = student;
    controller.isLoggedIn.value = true;
  }

}
