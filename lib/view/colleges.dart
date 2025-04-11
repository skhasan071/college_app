import 'package:college_app/constants/colors.dart';
import 'package:college_app/constants/filter.dart';
import 'package:college_app/constants/ui_helper.dart';
import 'package:college_app/constants/card.dart';
import 'package:college_app/services/college_services.dart';
import 'package:college_app/services/user_services.dart';
import 'package:college_app/view_model/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/college.dart';
import '../view_model/profile_controller.dart';

class Colleges extends StatefulWidget {
  Colleges({super.key});

  @override
  State<Colleges> createState() => _CollegesState();
}

class _CollegesState extends State<Colleges> {

  var controller = Get.find<Controller>();
  var profile = Get.find<ProfileController>();

  List<College> states = [];
  List<College> cities = [];
  List<College> rankings = [];
  List<College> countries = [];
  List<College> private = [];
  List<College> public = [];

  @override
  void initState() {

    super.initState();

    getColleges();

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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Text(
                  "Hi, Name",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              _buildSection("Colleges Based on NIRF Ranking", rankings),

              _buildBox(
                title: "Which colleges match your preferences?",
                buttonText: "Predict My College",
              ),

              _buildSection("Colleges Based on Location", countries),
              _buildSection("Colleges Based on State", states),
              _buildSection("Colleges Based on City", cities),
              _buildSection("Popular Government Colleges", private),
              _buildSection("Popular Private Colleges", private),

              _buildBox(
                title: "Want the latest insights on colleges?",
                buttonText: "Read Insights",
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<College> data) {
    final ScrollController scrollController = ScrollController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
        SizedBox(
          height: 400,
          child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder:
                (context, index) => CardStructure(
                  collegeName: data[index].name,
                  coursesCount: 12,
                  feeRange: "Fees",
                  location: data[index].country,
                  ranking: data[index].ranking.toString(),
                ),
          ),
        ),
        const SizedBox(height: 10),
        // Arrows below card list
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
  }

  Widget _buildBox({required String title, required String buttonText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
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
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: UiHelper.getPrimaryBtn(title: buttonText, callback: () {
                controller.navSelectedIndex.value = 3;
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getColleges() async {

    states = await CollegeServices.filterCollegesByStream(stream: "Engineering", state: "Maharashtra");
    cities = await CollegeServices.filterCollegesByStream(stream: "Engineering", city: "Mumbai");
    countries = await CollegeServices.filterCollegesByStream(stream: "Engineering", country: "India");
    rankings = await CollegeServices.filterCollegesByRanking(stream: "Engineering");
    private = await StudentService.getPrivateCollegesByInterest(profile.profile.value!.id);

    setState(() {});

  }

}
