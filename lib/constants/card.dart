import 'package:flutter/material.dart';
import 'package:college_app/constants/ui_helper.dart';
import 'package:college_app/constants/colors.dart';
import 'package:college_app/view_model/saveController.dart';
import 'package:get/get.dart';

class CardStructure extends StatelessWidget {
  final String collegeName;
  final int coursesCount;
  final String feeRange;
  final String location;
  final String ranking;

  final double? width;
  const CardStructure({
    Key? key,
    this.width,
    required this.collegeName,
    required this.coursesCount,
    required this.feeRange,
    required this.location,
    required this.ranking,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(saveController());

    return Container(
      width: width ?? 275, // default to 275 unless overridden
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        color: Clr.cardClr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
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
                      onTap: () {
                        controller.toggleSave(collegeName);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),

                        child: Icon(
                          controller.isSaved(collegeName)
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
                  Text(
                    collegeName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.star, size: 18, color: Clr.primaryBtnClr),
                      Icon(Icons.star, size: 18, color: Clr.primaryBtnClr),
                      Icon(Icons.star, size: 18, color: Clr.primaryBtnClr),
                      Icon(Icons.star, size: 18, color: Clr.primaryBtnClr),
                      Icon(Icons.star_half, size: 18, color: Clr.primaryBtnClr),
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
                      Text(location),
                      const SizedBox(width: 8),
                      Text("#$ranking NIRF"),
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
    );
  }

  static Widget _buildInfoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
