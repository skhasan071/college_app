import 'package:flutter/material.dart';
import 'package:college_app/constants/ui_helper.dart';
import 'package:college_app/constants/colors.dart';

class CompareColleges extends StatelessWidget {
  const CompareColleges({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                color: Clr.primaryBtnClr,
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
                  child: _collegeLogoWithName(
                    'IIT Delhi - Indian Institute of Technology',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _collegeLogoWithName(
                    'Indian Institute of Technology, Bombay',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            _infoRow('Location', ['New Delhi, India', 'Mumbai, India']),
            _infoRow('Cutoff', ['650 – 720', '680 – 730']),
            _infoRow('Fees', ['₹2.5 LPA', '₹3 LPA']),
            _infoRow('Courses Offered', [
              'B.Tech, M.Tech, MBA',
              'B.Tech, M.Sc, MBA',
            ]),
            _infoRow('Rating', ['4.7 / 5', '4.5 / 5']),
            _infoRow('NIRF Ranking', ['#2', '#3']),
            _infoRow('Admission Probability', ['High', 'Medium']),
            const Divider(color: Colors.black, thickness: 1),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                UiHelper.getPrimaryBtn(
                  title: "View Details",
                  callback: () {},
                  icon: Icons.arrow_forward,
                ),
                UiHelper.getPrimaryBtn(
                  title: "View Details",
                  callback: () {},
                  icon: Icons.arrow_forward,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _collegeLogoWithName(String name) {
    return Column(
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(color: Colors.grey[300]),
          child: const Center(child: Icon(Icons.image, size: 40)),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _infoRow(String label, List<String> values) {
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
              color: Clr.primaryBtnClr,
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
                color: Colors.grey[300],
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    values[0],
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Container(width: 1, color: Colors.black),
            // Right column (white/default)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    values[1],
                    style: const TextStyle(fontWeight: FontWeight.w500),
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
