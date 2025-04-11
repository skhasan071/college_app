import 'package:college_app/constants/colors.dart';
import 'package:college_app/constants/filter.dart';
import 'package:college_app/constants/ui_helper.dart';
import 'package:college_app/constants/card.dart';
import 'package:college_app/view_model/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Colleges extends StatelessWidget {
  Colleges({super.key});

  var controller = Get.put(Controller());

  final List<Map<String, dynamic>> colleges = [
    {
      'name': 'IIT Delhi - Indian Institute of Technology',
      'courses': 18,
      'fees': '₹2.97 L - 6.87 L',
      'location': 'Delhi',
      'ranking': '27',
    },
    {
      'name': 'IIT Bombay',
      'courses': 22,
      'fees': '₹3.10 L - 7.20 L',
      'location': 'Mumbai',
      'ranking': '15',
    },
  ];

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

              _buildSection("Colleges Based on NIRF Ranking", colleges),

              _buildBox(
                title: "Which colleges match your preferences?",
                buttonText: "Predict My College",
              ),

              _buildSection("Colleges Based on Location", colleges),
              _buildSection("Colleges Based on State", colleges),
              _buildSection("Colleges Based on City", colleges),
              _buildSection("Popular Government Colleges", colleges),
              _buildSection("Popular Private Colleges", colleges),

              _buildBox(
                title: "Want the latest insights on colleges?",
                buttonText: "Read Insights",
              ),

              // ⬇️ Add this
              _buildFAQs(),

              const SizedBox(height: 30),

              // Discover More Features section
              const Text(
                "Discover more features",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              Column(
                children: [
                  _featureCard(
                    title: "College Prediction",
                    description:
                        "Get personalized college recommendations based on your course preferences and scores.",
                    onTap: () {
                      controller.navSelectedIndex.value = 3;
                    },
                  ),
                  const SizedBox(height: 12),
                  _featureCard(
                    title: "Compare Colleges",
                    description:
                        "Easily compare multiple colleges side by side on parameters like rankings, fees, and placements.",
                    onTap: () {
                      controller.navSelectedIndex.value = 1;
                    },
                  ),
                  const SizedBox(height: 12),
                  _featureCard(
                    title: "AI Assistance",
                    description:
                        "Get instant support and guidance from AI-powered tools to simplify your college search.",
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Map<String, dynamic>> data) {
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
                  collegeName: data[index]['name'],
                  coursesCount: data[index]['courses'],
                  feeRange: data[index]['fees'],
                  location: data[index]['location'],
                  ranking: data[index]['ranking'],
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

  Widget _buildFAQs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FAQs',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildFAQItem(
            question: "What is NIRF?",
            answer:
                "The National Institutional Ranking Framework (NIRF) is a methodology adopted by the MHRD to rank institutions of higher education in India.",
          ),
          _buildFAQItem(
            question: "What are top courses in India?",
            answer:
                "- B.Tech in Computer Science\n- MBBS\n- BBA, B.Com\n- B.Sc, M.Sc in core sciences\n- Engineering & Management programs",
          ),
          _buildFAQItem(
            question: "How to apply college important?",
            answer:
                "Choosing the right college depends on rank, course availability, faculty, placement, location, and fees.",
          ),
          _buildFAQItem(
            question: "Where can I check cutoffs?",
            answer:
                "You can check cutoffs on college official websites or platforms like NIRF, JoSAA, etc.",
          ),
          _buildFAQItem(
            question: "How can I select the best college?",
            answer:
                "Filter colleges based on rank, fees, placements, location, etc. Use predictors to help you shortlist.",
          ),
          const SizedBox(height: 30),

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Clr.primaryBtnClr),
            ),
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Need help choosing the right college?",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    UiHelper.getPrimaryBtn(title: "Chat Now", callback: () {}),
                    const SizedBox(width: 12),
                    UiHelper.getSecondaryBtn(
                      title: "Reques a Call",
                      callback: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(answer, style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  Widget _featureCard({
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Clr.cardClr),
        child: Row(
          children: [
            // Placeholder for image or icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
              ),
              child: const Icon(Icons.image, color: Colors.grey),
            ),

            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward, size: 25, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
