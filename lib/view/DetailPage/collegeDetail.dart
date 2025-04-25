import 'dart:convert';

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
import 'package:http/http.dart' as http;

import '../../model/Placement.dart';
import '../../model/college.dart';

class CollegeDetail extends StatefulWidget {
  final College college;

  CollegeDetail({
    required this.college,
    super.key,
    required String collegeName,
    required String state,
  });

  @override
  State<CollegeDetail> createState() => _CollegeDetailState();
}

class _CollegeDetailState extends State<CollegeDetail> {
  final tabController = Get.put(CollegeTabController());

  final saveCtrl = Get.put(saveController());
  late Placement? placementData;
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchPlacementData();
  }
  Future<void> fetchPlacementData() async {
    final url = 'http://localhost:8080/api/colleges/placement/${widget.college.id}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        setState(() {
          placementData = Placement.fromJson(data[0]);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = "No placement data available for this college.";
        });
      }
    } else {
      setState(() {
        isLoading = false;
        errorMessage = "Error fetching placement data.";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.college.name, style: const TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body:isLoading
          ? Center(child: CircularProgressIndicator())  // Show loader while fetching
          : placementData == null || errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage.isNotEmpty ? errorMessage : 'No data available'))
          :
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ College Banner Image
          widget.college.image.isNotEmpty
              ? Image.network(
            widget.college.image,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          )
              : Container(
            height: 180,
            color: Colors.grey[300],
            child: const Center(child: Icon(Icons.image, size: 50)),
          ),

          // ✅ College Name and State
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.college.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      widget.college.state,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
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
                              builder: (context) => CompareWith(clg: widget.college),
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

          // ✅ NAAC, Rank, Establishment
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "#${widget.college.ranking}\nNIRF Rank",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${widget.college.naacGrade}\nNAAC Grade",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${widget.college.estYear}\nEstablished",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      Get.to(() => Courses(widget.college.id));
                      break;
                    case "Scholarship & Aid":
                      Get.to(() => Scholarships(
                          collegeId: widget.college.id,
                          collegeName: widget.college.name // Pass the college name here as well
                      ));
                      break;
                    case "Reviews":
                      Get.to(() => Reviews(widget.college.id));
                      break;
                    case "Placements":
                      Get.to(() => PlacementDetails(collegeId: widget.college.id,));
                      break;
                    case "Admission & Eligibility":
                      Get.to(() => const Admission());
                      break;
                    case "Cost & Location":
                      Get.to(() => const Cost());
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
                    case "Hostel & Compus Life":
                      Get.to(()=>const Hostel());
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
              physics: NeverScrollableScrollPhysics(),
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
                              children: [
                                QuickHighlights(
                                  title: "Acceptance Rate",
                                  value: "${widget.college.acceptanceRate}",
                                ),
                                QuickHighlights(
                                  title: "Placement Rate",
                                  value: placementData!.placementRate,
                                ),
                                QuickHighlights(
                                  title: "Avg Package",
                                  value: placementData!.averagePackage,
                                ),
                                QuickHighlights(
                                  title: "Student Rating",
                                  value: "4.8/5.0",
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
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
                              children: [
                                const Text(
                                  "Highest Package",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  placementData!.highestPackage,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                Text(
                                  "Average Package",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  placementData!.averagePackage,
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
                              children: placementData!.companiesVisited.map((company) {
                                return _buildRecruiterChip(company);
                              }).toList(),
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

Widget _buildRecruiterChip(String label) {
  return Container(
    width: 100,
    height: 50,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      label,
      style: const TextStyle(fontSize: 16, color: Colors.black),
    ),
  );
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
