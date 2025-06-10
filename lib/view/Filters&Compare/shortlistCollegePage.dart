import 'package:college_app/constants/colors.dart';
import 'package:college_app/model/college.dart';
import 'package:college_app/services/user_services.dart';
import 'package:college_app/view_model/profile_controller.dart';
import 'package:college_app/view_model/themeController.dart';
import 'package:flutter/material.dart';
import 'package:college_app/constants/card.dart';
import 'package:get/get.dart';
import '../../services/shortListCollegeController.dart';

class ShortlistedCollegesPage extends StatefulWidget {
  const ShortlistedCollegesPage({super.key});

  @override
  State<ShortlistedCollegesPage> createState() =>
      _ShortlistedCollegesPageState();
}

class _ShortlistedCollegesPageState extends State<ShortlistedCollegesPage> {
  List<College> colleges = [];
  int shortlistedCollegesCount = 0; // Variable to hold the count
  final shortlistedCollegesController = Get.put(
    ShortlistedCollegesController(),
  ); // Get the controller

  var profile = Get.find<ProfileController>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getColleges();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final theme = ThemeController.to.currentTheme;
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your Top Picks, One Step Closer!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(height: 4),
              isLoading
                  ? SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: theme.filterSelectedColor,
                    ),
                  )
                  : Text(
                    "Shortlisted Colleges (${shortlistedCollegesController.shortlistedCollegesCount.value})",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Clr.primaryBtnClr,
                      fontSize: 33,
                    ),
                  ),
              const SizedBox(height: 4),
              const Text(
                "Explore the colleges you’ve saved for future reference.",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 10),

              //const SizedBox(height: 16),
              colleges.isNotEmpty
                  ? Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: theme.backgroundGradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: theme.boxShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          itemBuilder: (context, index) {
                            College clg = colleges[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: CardStructure(
                                width: double.infinity,
                                collegeID: clg.id,
                                collegeName: clg.name,
                                feeRange: clg.feeRange,
                                state: clg.country,
                                ranking: clg.ranking.toString(),
                                studId: profile.profile.value!.id,
                                clgId: clg.id,
                                clg: clg,
                              ),
                            );
                          },
                          itemCount: colleges.length,
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(), // important!
                        ),
                      ],
                    ),
                  )
                  : Center(
                    child: Text(
                      "No Colleges Shortlisted",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> getColleges() async {
    isLoading = true;
    setState(() {}); // Show loader

    colleges = await StudentService.getFavoriteColleges(
      profile.profile.value!.id,
    );

    shortlistedCollegesController.shortlistedCollegesCount.value =
        colleges.length;

    isLoading = false;
    setState(() {}); // Hide loader and update UI
  }
}
