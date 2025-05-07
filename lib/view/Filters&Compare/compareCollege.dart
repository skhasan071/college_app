import 'package:college_app/view/DetailPage/collegeDetail.dart';
import 'package:college_app/view_model/themeController.dart';
import 'package:flutter/material.dart';
import 'package:college_app/constants/ui_helper.dart';
import 'package:college_app/constants/colors.dart';
import 'package:college_app/services/user_services.dart';
import 'package:college_app/model/college.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CompareColleges extends StatelessWidget {
  final String collegeImage;
  final College clg;
  final College college;
  final String collegeId;
  final String collegeName;
  final String ranking;
  final String feeRange;
  final String state;
  final College firstCollege;
  final College secondCollege;

  const CompareColleges({
    super.key,
    required this.clg,
    required this.college,
    required this.collegeName,
    required this.collegeId,
    required this.ranking,
    required this.feeRange,
    required this.state,
    required this.collegeImage,
    required this.firstCollege,
    required this.secondCollege,
  });
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final theme = ThemeController.to.currentTheme;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 5,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Find the Best Fit',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Compare. Decide. Succeed!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(height: 8),
              Text(
                'Compare Colleges',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.filterSelectedColor,
                  fontSize: 33,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Side-by-side comparison to find your best fit.',
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: _collegeLogoWithName(firstCollege.name, clg.image),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _collegeLogoWithName(secondCollege.name, clg.image),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              _infoRow('Location', [firstCollege.state, secondCollege.state]),

              _infoRow('Cutoff', [' - ', ' - ']),
              _infoRow('Fees', [firstCollege.feeRange, secondCollege.feeRange]),
              _infoRow('Courses Offered', [' - ', ' - ']),
              _infoRow('Rating', [' - ', ' - ']),
              _infoRow('NIRF Ranking', [
                '₹${firstCollege.ranking.toString()}',
                '₹${secondCollege.ranking.toString()}',
              ]),

              _infoRow('Admission Probability', [' - ', ' - ']),
              const Divider(color: Colors.black, thickness: 1),
            ],
          ),
        ),
      );
    });
  }

  Widget _collegeLogoWithName(String name, String imageUrl) {
    return Column(
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(color: Colors.grey[300]),
          child:
              imageUrl.isNotEmpty
                  ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.broken_image, size: 40),
                      );
                    },
                  )
                  : const Center(child: Icon(Icons.image, size: 40)),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 70,
          child: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _infoRow(String label, List<String> values) {
    final theme = ThemeController.to.currentTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Colors.black, thickness: 1),
        const SizedBox(height: 18),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Text(
            '$label:',
            style: TextStyle(
              color: theme.filterSelectedColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const Divider(color: Colors.black, thickness: 1),

        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(gradient: theme.backgroundGradient),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    values[0],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Container(width: 1, color: Colors.black),

            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    values[1],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
