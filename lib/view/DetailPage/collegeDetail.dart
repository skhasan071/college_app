import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:college_app/view_model/tabController.dart';
import 'package:college_app/view_model/saveController.dart';
import 'package:college_app/constants/colors.dart';

import '../../model/college.dart';

class CollegeDetail extends StatelessWidget {

  College college;

  CollegeDetail({required this.college, super.key});

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
            onPressed: () {

            },
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

                Text(
                  college.state,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  child: const Text("Apply Now"),
                ),
              ],
            ),
          ),

          // Info Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("#${college.ranking}\nNIRF Rank", textAlign: TextAlign.center),
                Text("A++\nNAAC Grade", textAlign: TextAlign.center),
                Text("1961\nEstablished", textAlign: TextAlign.center),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Tab Bar
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            controller: tabController.tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: tabController.tabs.map((tab) => Tab(text: tab)).toList(),
          ),

          // TabBar View
          Expanded(
            child: TabBarView(
              controller: tabController.tabController,
              children:
                  tabController.tabs.map((tab) {
                    if (tab == "Overview") {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Quick Highlights",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text("• Acceptance Rate: 2.8%"),
                              Text("• Placement Rate: 98.5%"),
                              Text("• Avg Package: ₹25.4 LPA"),
                              Text("• Student Rating: 4.8/5.0"),
                              SizedBox(height: 20),
                              Text(
                                "About the Institute",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Indian Institute of Technology, Delhi (IIT Delhi) is one of India's top engineering institutions known for academic excellence, cutting-edge research, and a vibrant campus life.",
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text("Redirect to another page"),
                      );
                    }
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
