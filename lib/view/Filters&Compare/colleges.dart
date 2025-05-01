import 'package:college_app/constants/colors.dart';
import 'package:college_app/constants/filter.dart';
import 'package:college_app/constants/ui_helper.dart';
import 'package:college_app/constants/card.dart';
import 'package:college_app/main.dart';
import 'package:college_app/model/college.dart';
import 'package:college_app/services/college_services.dart';
import 'package:college_app/view_model/controller.dart';
import 'package:college_app/view_model/profile_controller.dart';
import 'package:college_app/view_model/saveController.dart';
import 'package:college_app/view_model/themeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/user_services.dart';
import '../DetailPage/collegeDetail.dart';

class Colleges extends StatefulWidget {
  Colleges({super.key});

  @override
  State<Colleges> createState() => _CollegesState();
}

class _CollegesState extends State<Colleges> {
  var controller = Get.put(Controller());
  var saveCtrl = Get.put(saveController());
  var profile = Get.put(ProfileController());

  List<College> colleges = [];
  List<College> countries = [];
  List<College> states = [];
  List<College> cities = [];
  List<College> rankings = [];
  List<College> privates = [];
  List<College> public = [];
  bool isLoading = false; // To track loading state

  @override
  void initState() {
    super.initState();
    getColleges();
    getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Text(
                  "Hi, ${profile.profile.value == null ? "User" : profile.profile.value!.name}",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              !controller.isGuestIn.value
                  ? rankings.isNotEmpty
                      ? _buildSection(
                        "Colleges Based on NIRF Ranking",
                        rankings,
                      )
                      : Container()
                  : Container(),

              _buildBox(
                title: "Which colleges match your preferences?",
                buttonText: "Predict My College",
                pageNo: 3
              ),

              rankings.isNotEmpty
                  ? _buildSection("Colleges Based on State", states)
                  : Container(),
              countries.isNotEmpty
                  ? _buildSection("Colleges Based on Country", countries)
                  : Container(),
              cities.isNotEmpty
                  ? _buildSection("Colleges Based on City", cities)
                  : Container(),
              controller.isLoggedIn.value && public.isNotEmpty
                  ? _buildSection("Popular Government Colleges", public)
                  : Container(),
              controller.isLoggedIn.value && privates.isNotEmpty
                  ? _buildSection("Popular Private Colleges", privates)
                  : Container(),

              _buildBox(
                title: "Want the latest insights on colleges?",
                buttonText: "Read Insights",
                pageNo: 2
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<College> data) {
    final ScrollController scrollController = ScrollController();

    return Obx(() {
      final theme = ThemeController.to.currentTheme;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Wrap title, filters, cards
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            decoration: BoxDecoration(
              gradient: theme.backgroundGradient,
              boxShadow: theme.boxShadow,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Filters
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: const [
                        Filter(title: "View All"),
                        SizedBox(width: 8),
                        Filter(title: "Engineering"),
                        SizedBox(width: 8),
                        Filter(title: "Medical"),
                        SizedBox(width: 8),
                        Filter(title: "Dont Know"),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Cards
                SizedBox(
                  height: 430,
                  child: ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder:
                        (context, index) => GestureDetector(
                          onTap: () async {
                            setState(() {
                              isLoading = true; // Show loader on click
                            });

                            // Simulate loading delay (e.g., 1 second)
                            await Future.delayed(Duration(seconds: 5));

                            // Navigate to CollegeDetail
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => CollegeDetail(
                                      college: data[index],
                                      collegeName: data[index].name,
                                      lat: data[index].lat,
                                      long: data[index].long,
                                      state: data[index].state,
                                    ),
                              ),
                            );

                            setState(() {
                              isLoading = false; // Hide loader after navigation
                            });
                          },
                          child: CardStructure(
                            collegeID: data[index].id,
                            collegeName: data[index].name,
                            coursesCount: data[index].courseCount,
                            feeRange: data[index].fees.toString(),
                            state: data[index].state,
                            ranking: data[index].ranking.toString(),
                            studId:
                                !controller.isGuestIn.value
                                    ? profile.profile.value!.id
                                    : "Nothing",
                            clgId: data[index].id,
                            clg: data[index],
                          ),
                        ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Arrows (outside the container)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const CircleBorder(),
                  side: BorderSide(color: Clr.primaryBtnClr),
                  padding: const EdgeInsets.all(10),
                ),
                onPressed: () {
                  scrollController.animateTo(
                    scrollController.offset - 300,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Icon(Icons.arrow_back_ios_new, size: 18),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const CircleBorder(),
                  side: BorderSide(color: Clr.primaryBtnClr),
                  padding: const EdgeInsets.all(10),
                ),
                onPressed: () {
                  scrollController.animateTo(
                    scrollController.offset + 300,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Icon(Icons.arrow_forward_ios, size: 18),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildBox({required String title, required String buttonText, required int pageNo}) {
    return Obx(() {
      final theme = ThemeController.to.currentTheme;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: theme.boxGradient,
            border: Border.all(color: Clr.primaryBtnClr),
          ),
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: UiHelper.getPrimaryBtn(
                  title: buttonText,
                  callback: () {
                    controller.navSelectedIndex.value = pageNo;
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> getFavorites() async {
    // Check if profile is null before accessing id
    if (profile.profile.value != null) {
      List<College> colleges = await StudentService.getFavoriteColleges(
        profile.profile.value!.id,
      );
      for (College college in colleges) {
        saveCtrl.savedColleges.add(college.id);
      }
    } else {
      // Handle case when profile is null (e.g., show a message or return early)
      print('Profile is null, cannot fetch favorite colleges.');
    }
  }

  Future<void> getColleges() async {
    if (controller.isLoggedIn.value) {
      rankings = await StudentService.getCollegesByRanking(
        profile.profile.value!.id,
      );
      privates = await StudentService.getPrivateCollegesByInterest(
        profile.profile.value!.id,
      );
      countries = await CollegeServices.fetchFilteredColleges(
        streams: profile.profile.value!.interestedStreams!,
        country: "India",
      );
      states = await CollegeServices.fetchFilteredColleges(
        streams: profile.profile.value!.interestedStreams!,
        state: "Maharashtra",
      );
      cities = await CollegeServices.fetchFilteredColleges(
        streams: profile.profile.value!.interestedStreams!,
        city: "Mumbai",
      );
    } else {
      countries = await CollegeServices.fetchFilteredColleges(
        streams: profile.interestedStreams,
        country: "India",
      );
      states = await CollegeServices.fetchFilteredColleges(
        streams: profile.interestedStreams,
        state: "Maharashtra",
      );
      cities = await CollegeServices.fetchFilteredColleges(
        streams: profile.interestedStreams,
        city: "Mumbai",
      );
    }

    setState(() {});
  }
}
