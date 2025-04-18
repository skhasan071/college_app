import 'package:college_app/model/college.dart';
import 'package:college_app/services/user_services.dart';
import 'package:college_app/view/DetailPage/collegeDetail.dart';
import 'package:flutter/material.dart';
import 'package:college_app/constants/ui_helper.dart';
import 'package:college_app/constants/colors.dart';
import 'package:college_app/view_model/saveController.dart';
import 'package:get/get.dart';

class CardStructure extends StatelessWidget {
  final String collegeID;
  final String collegeName;
  final int coursesCount;
  final String feeRange;
  final String state;
  final String ranking;
  final String studId;
  final String clgId;
  College clg;

  final double? width;
  CardStructure({
    Key? key,
    this.width,
    required this.clg,
    required this.collegeID,
    required this.collegeName,
    required this.coursesCount,
    required this.feeRange,
    required this.state,
    required this.ranking,
    required this.studId,
    required this.clgId,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(saveController());

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    CollegeDetail(college: clg, collegeName: '', state: ''),
          ),
        );
      },
      child: Container(
        width: width ?? 285,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Container(
          decoration: BoxDecoration(
            color: Clr.cardClr,
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.grey.shade300),
                    child: const Center(
                      child: Icon(Icons.image, size: 40, color: Colors.grey),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 4,
                    child: Obx(
                      () => InkWell(
                        onTap: () async {
                          if (controller.isSaved(collegeID)) {
                            bool success = await remove(studId, clgId);
                            if (success) {
                              controller.toggleSave(collegeID);
                            }
                          } else {
                            bool success = await save(studId, clgId);
                            if (success) {
                              controller.toggleSave(collegeID);
                            }
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            controller.isSaved(collegeID)
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            size: 27,
                            color: Clr.primaryBtnClr,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 70,
                      child: Text(
                        collegeName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.star, size: 18, color: Clr.primaryBtnClr),
                        Icon(Icons.star, size: 18, color: Clr.primaryBtnClr),
                        Icon(Icons.star, size: 18, color: Clr.primaryBtnClr),
                        Icon(Icons.star, size: 18, color: Clr.primaryBtnClr),
                        Icon(
                          Icons.star_half,
                          size: 18,
                          color: Clr.primaryBtnClr,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoColumn(
                          "Courses Offered",
                          "$coursesCount courses",
                        ),
                        _buildInfoColumn("Total Fees Range", feeRange),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          state,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "#$ranking NIRF",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: UiHelper.getPrimaryBtn(
                        title: "Brochure",
                        callback: () {},
                        icon: Icons.download,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildInfoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 15)),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  static Future<bool> save(studId, clgId) async {
    Map<String, dynamic>? msg = await StudentService.addToFavorites(
      studentId: studId,
      collegeId: clgId,
    );
    return msg != null;
  }

  static Future<bool> remove(studId, clgId) async {
    bool msg = await StudentService.removeFromFavorites(studId, clgId);
    return msg;
  }
}
