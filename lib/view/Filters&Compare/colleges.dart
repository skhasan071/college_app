import 'package:college_app/constants/colors.dart';
import 'package:college_app/constants/filter.dart';
import 'package:college_app/constants/ui_helper.dart';
import 'package:college_app/constants/card.dart';
import 'package:college_app/model/college.dart';
import 'package:college_app/services/college_services.dart';
import 'package:college_app/view_model/controller.dart';
import 'package:college_app/view_model/profile_controller.dart';
import 'package:college_app/view_model/saveController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/user_services.dart';

class Colleges extends StatefulWidget {
  Colleges({super.key});

  @override
  State<Colleges> createState() => _CollegesState();
}

class _CollegesState extends State<Colleges> {
  var controller = Get.put(Controller());
  var saveCtrl = Get.put(saveController());
  var profile = Get.put(ProfileController());

  List<College> colleges = [
    College(
      id: '1',
      name: 'IIT Delhi - Indian Institute of Technology',
      city: '',
      state: 'Delhi',
      country: '',
      ranking: 27,
      brochure: '',
      image: '',
      collegeInfo: '',
      stream: '',
      type: '',
      courseCount: 18,
      fees: 20000,
    ),
    College(
      id: '2',
      name: 'IIT Bombay',
      city: '',
      state: 'Maharashtra',
      country: '',
      ranking: 15,
      brochure: '',
      image: '',
      collegeInfo: '',
      stream: '',
      type: '',
      courseCount: 19,
      fees: 90000,
    ),
  ];

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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Text(
                  "Hi, Name",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              _buildSection("Colleges Based on NIRF Ranking", colleges),

              _buildBox(
                title: "Which colleges match your preferences?",
                buttonText: "Predict My College",
              ),

              _buildSection("Colleges Based on Country", colleges),
              _buildSection("Colleges Based on State", colleges),
              _buildSection("Colleges Based on City", colleges),
              _buildSection("Popular Government Colleges", colleges),
              _buildSection("Popular Private Colleges", colleges),

              _buildBox(
                title: "Want the latest insights on colleges?",
                buttonText: "Read Insights",
              ),
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
        SizedBox(
          height: 420,
          child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder:
                (context, index) => CardStructure(
                  collegeID: data[index].id,
                  collegeName: data[index].name,
                  coursesCount: data[index].courseCount,
                  feeRange: data[index].fees.toString(),
                  state: data[index].state,
                  ranking: data[index].ranking.toString(),
                  studId: profile.profile.value!.id,
                  clgId: data[index].id,
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
              child: UiHelper.getPrimaryBtn(
                title: buttonText,
                callback: () {
                  controller.navSelectedIndex.value = 3;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getFavorites() async {
    List<College> colleges = await StudentService.getFavoriteColleges(profile.profile.value!.id);
    for(College college in colleges){
      saveCtrl.savedColleges.add(college.id);
    }
  }

  Future<void> getColleges() async {
    colleges = await CollegeServices.getColleges();
    setState(() {});
  }

}
