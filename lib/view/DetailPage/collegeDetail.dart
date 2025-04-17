import 'package:college_app/view/Filters&Compare/compareWith.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:college_app/view_model/tabController.dart';
import 'package:college_app/view_model/saveController.dart';
import 'package:college_app/constants/colors.dart';
import 'package:college_app/view/DetailPage/courses.dart';
import 'package:college_app/view/DetailPage/review.dart';
import 'package:college_app/view/DetailPage/placementDetails.dart';
import 'package:college_app/view/DetailPage/admission.dart';
import 'package:college_app/view/DetailPage/cost.dart';
import 'package:college_app/view/DetailPage/scholarships.dart';
import 'package:college_app/view/DetailPage/distanceFromHome.dart';
import 'package:college_app/view/DetailPage/insights.dart';
import 'package:college_app/view/DetailPage/Q&A.dart';
import 'package:college_app/view/DetailPage/hostel.dart';
import 'package:college_app/view/DetailPage/cutoff.dart';

import '../../model/college.dart';

class CollegeDetail extends StatelessWidget {
  College college;

  CollegeDetail({
    required this.college,
    super.key,
    required String collegeName,
    required String state,
  });

  final tabController = Get.put(CollegeTabController());
  final saveCtrl = Get.put(saveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Obx(
            () => InkWell(
              onTap: () {
                saveCtrl.toggleSave(college.id);
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                child: Icon(
                  saveCtrl.isSaved(college.id)
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  size: 27,
                  color: Clr.primaryBtnClr,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            color: Colors.grey[300],
            child: const Center(child: Icon(Icons.image, size: 50)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  college.name,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      college.state,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Apply Now logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          "Apply Now",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompareWith(clg: college),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          side: const BorderSide(color: Colors.black),
                        ),
                        child: const Text(
                          "Compare",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "#1\nNIRF Rank",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "A++\nNAAC Grade",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "1961\nEstablished",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.4),
                bottom: BorderSide(color: Colors.grey, width: 0.4),
              ),
            ),
            child: TabBar(
              isScrollable: true,
              controller: tabController.tabController,
              labelColor: Colors.white,
              tabAlignment: TabAlignment.start,
              unselectedLabelColor: Colors.black,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
              indicator: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
              ),
              onTap: (index) {
                final selectedTab = tabController.tabs[index];
                if (selectedTab != "Overview") {
                  switch (selectedTab) {
                    case "Courses":
                      Get.to(() => const Courses());
                      break;
                    case "Reviews":
                      Get.to(() => Reviews());
                      break;
                    case "Placements":
                      Get.to(() => const PlacementDetails());
                      break;
                    case "Admission & Eligibility":
                      Get.to(() => const Admission());
                      break;
                    case "Cost & Location":
                      Get.to(() => const Cost());
                      break;
                    case "Scholarship & Aid":
                      Get.to(() => const Scholarships());
                      break;
                    case "Distance from Hometown":
                      Get.to(() => const DistanceFromHometown());
                      break;
                    case "Latest News & Insights":
                      Get.to(() => const Insights());
                      break;
                    case "Q & A":
                      Get.to(() => const QAPage());
                      break;
                    case "Hostel & Campus Life":
                      Get.to(() => const Hostel());
                      break;
                    case "Cut-offs & Ranking":
                      Get.to(() => const Cutoff());
                      break;
                  }

                  Future.delayed(const Duration(milliseconds: 100), () {
                    tabController.tabController.index = 0;
                  });
                }
              },
              tabs:
                  tabController.tabs
                      .map(
                        (tab) => Tab(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 12,
                            ),
                            child: Text(tab),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController.tabController,
              children:
                  tabController.tabs.map((tab) {
                    if (tab == "Overview") {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Quick Highlights",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 2.0,
                              children: const [
                                QuickHighlights(
                                  title: "Acceptance Rate",
                                  value: "2.8%",
                                ),
                                QuickHighlights(
                                  title: "Placement Rate",
                                  value: "98.5%",
                                ),
                                QuickHighlights(
                                  title: "Avg Package",
                                  value: "₹25.4 LPA",
                                ),
                                QuickHighlights(
                                  title: "Student Rating",
                                  value: "4.8/5.0",
                                ),
                              ],
                            ),
                            const Divider(color: Colors.grey, thickness: 0.5),
                            const SizedBox(height: 20),
                            const Text(
                              "Popular Courses",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const CourseTile(
                              course: "B.Tech Computer Science",
                              fee: "₹2.2L/yr",
                              duration: "4 Years • Full Time",
                            ),
                            const CourseTile(
                              course: "B.Tech Mechanical",
                              fee: "₹2.2L/yr",
                              duration: "4 Years • Full Time",
                            ),
                            const Divider(color: Colors.grey, thickness: 1),
                            const SizedBox(height: 20),
                            const Text(
                              "Placement Statistics",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Highest Package",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "₹1.8 Cr/annum",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Average Package",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "₹25.4 LPA",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            const Divider(color: Colors.grey, thickness: 1),
                            const SizedBox(height: 20),
                            const Text(
                              "Top Recruiters",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: const [
                                RecruiterChip(name: "Google"),
                                RecruiterChip(name: "Microsoft"),
                                RecruiterChip(name: "Amazon"),
                                RecruiterChip(name: "Apple"),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Campus Life",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: const [
                                Expanded(
                                  child: CampusLifeCard(title: "Library"),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: CampusLifeCard(
                                    title: "Sports Complex",
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class QuickHighlights extends StatelessWidget {
  final String title;
  final String value;

  const QuickHighlights({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  final String course;
  final String fee;
  final String duration;

  const CourseTile({
    required this.course,
    required this.fee,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            duration,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            fee,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class RecruiterChip extends StatelessWidget {
  final String name;

  const RecruiterChip({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 19,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class CampusLifeCard extends StatelessWidget {
  final String title;

  const CampusLifeCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
