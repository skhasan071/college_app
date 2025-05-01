import 'package:college_app/constants/customTheme.dart';
import 'package:college_app/model/college.dart';
import 'package:college_app/services/user_services.dart';
import 'package:college_app/view/DetailPage/collegeDetail.dart';
import 'package:college_app/view_model/themeController.dart';
import 'package:flutter/material.dart';
import 'package:college_app/constants/ui_helper.dart';
import 'package:college_app/constants/colors.dart';
import 'package:college_app/view_model/saveController.dart';
import 'package:get/get.dart';

import '../view_model/controller.dart';

class CardStructure extends StatelessWidget {
  final theme = ThemeController.to;
  final String collegeID;
  final String collegeName;
  final int coursesCount;
  final String feeRange;
  final String state;
  final String ranking;
  final String studId;
  final String clgId;
  College clg;
  var pfpController = Get.put(Controller());

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

    return Obx(() {
      final CustomTheme themes = theme.currentTheme;

      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      CollegeDetail(college: clg,collegeImage:clg.image,collegeName: clg.name, state: clg.state, lat: clg.lat, long: clg.long,),
            ),
          );
        },
        child: Container(
          width: width ?? 285,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Clr.cardClr,
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.grey.shade300),
                    child: Image.network(clg.image, fit: BoxFit.cover,),
                  ),
                  Positioned(
                    top: 8,
                    right: 4,
                    child: Obx(
                      () => InkWell(
                        onTap: () async {
                          if(pfpController.isGuestIn.value){

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Login First", style: TextStyle(color: Colors.white),),
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.black,
                                behavior: SnackBarBehavior.floating,
                              )
                            );

                          }else{
                            if (controller.isSaved(collegeID)) {
                              bool success = await remove(studId, clgId);
                              if (success){
                                controller.toggleSave(collegeID);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Removed from Shortlist", style: TextStyle(color: Colors.white),),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.black,
                                      behavior: SnackBarBehavior.floating,
                                    )
                                );
                              }
                            } else {
                              bool success = await save(studId, clgId);
                              if (success){
                                controller.toggleSave(collegeID);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Added To Shortlist", style: TextStyle(color: Colors.white),),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.black,
                                      behavior: SnackBarBehavior.floating,
                                    )
                                );
                              }
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
                            color: themes.saveIconColor,
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
                      children: List.generate(
                        4,
                        (index) =>
                            Icon(Icons.star, size: 18, color: themes.starColor),
                      )..add(
                        Icon(
                          Icons.star_half,
                          size: 18,
                          color: themes.starColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildInfoColumn(
                          "Courses Offered",
                          "$coursesCount courses",
                          themes
                        ),
                        _buildInfoColumn("Total Fees Range", feeRange, themes),
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
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: themes.nirfTextColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.download, size: 18),
                      label: const Text(
                        "Brochure",
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themes.brochureBtnColor,
                        foregroundColor: Colors.white,

                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildInfoColumn(String title, String value, CustomTheme themes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 15)),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: themes.courseCountColor,
          ),
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
