import 'package:college_app/constants/colors.dart';
import 'package:college_app/model/college.dart';
import 'package:college_app/services/college_services.dart';
import 'package:college_app/services/user_services.dart';
import 'package:college_app/view_model/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:college_app/constants/card.dart';
import 'package:college_app/view/Filters&Compare/colleges.dart';
import 'package:college_app/constants/filter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ShortlistedCollegesPage extends StatefulWidget {
  ShortlistedCollegesPage({super.key});

  @override
  State<ShortlistedCollegesPage> createState() =>
      _ShortlistedCollegesPageState();
}

class _ShortlistedCollegesPageState extends State<ShortlistedCollegesPage> {
  List<College> colleges = [];

  var profile = Get.find<ProfileController>();

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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Top Picks, One Step Closer!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(height: 4),
            Text(
              "Shortlisted Colleges",
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
            const SizedBox(height: 16),

            // Filter and Compare Buttons
            Row(
              children: [
                SizedBox(
                  width: 130,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.filter_alt_outlined,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Filter",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 43),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Compare Colleges",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            SingleChildScrollView(
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

            const SizedBox(height: 16),

            // College Cards
            Column(
              children: [
                ListView.builder(
                  itemBuilder: (context, index) {
                    College clg = colleges[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CardStructure(
                        width: double.infinity,
                        collegeID: clg.id,
                        collegeName: clg.name,
                        coursesCount: 10,
                        feeRange: '₹2.97 L - 6.87 L',
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getColleges() async {
    colleges = await StudentService.getFavoriteColleges(
        profile.profile.value!.id
    );
    setState(() {});
  }
}
