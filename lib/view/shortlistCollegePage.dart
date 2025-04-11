import 'package:college_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:college_app/constants/card.dart';
import 'package:college_app/view/colleges.dart';
import 'package:college_app/constants/filter.dart'; // Make sure Filter widget is in this file

class ShortlistedCollegesPage extends StatelessWidget {
  const ShortlistedCollegesPage({super.key});

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
              children: List.generate(
                5,
                (index) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: CardStructure(
                    width: double.infinity,
                    collegeName: 'IIT Delhi - Indian Institute of Technology',
                    coursesCount: 18,
                    feeRange: '₹2.97 L - 6.87 L',
                    location: 'Delhi',
                    ranking: '27',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
