import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Support & Help',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _featuresSection(),
          _buildDivider(),
          const Text(
            "Need help with the app? We've got you.",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          _subSectionTitle("FAQs:"),
          const FAQItem(
            question: "How do I log in?",
            answer:
                "Go to the login screen, enter your enrollment ID and password, then tap 'Login'.",
          ),
          const FAQItem(
            question: "How do I reset my password?",
            answer:
                "Tap 'Forgot Password' on the login screen and follow the instructions to reset it.",
          ),
          const FAQItem(
            question: "I submitted the wrong feedback — what do I do?",
            answer:
                "Contact your department head or email us to report it. We will guide you accordingly.",
          ),
          const FAQItem(
            question: "Can I edit my feedback?",
            answer:
                "No, once submitted, feedback cannot be changed. You may contact your department for help.",
          ),

          const FAQItem(
            question: "How do I search for colleges?",
            answer:
                "Use the search bar on the home page to find colleges by name, course, or location.",
          ),
          const FAQItem(
            question: "How does the college predictor work?",
            answer:
                "The predictor uses your entrance exam score and preferences to suggest suitable colleges.",
          ),
          const FAQItem(
            question: "Can I compare more than two colleges at once?",
            answer:
                "Currently, you can compare two colleges side-by-side. We plan to support more soon.",
          ),
          const FAQItem(
            question: "How is the ranking calculated?",
            answer:
                "Our rankings consider factors like placement stats, faculty, infrastructure, and student reviews.",
          ),
          _buildDivider(),

          _subSectionTitle("Contact Us:"),
          _infoText("Email: support@collegeapp.com"),
          _infoText("Response Time: 24–48 hours on working days."),
          _buildDivider(),

          _subSectionTitle("Report an Issue:"),
          _actionTile(
            title: "Tap here to report an issue",
            icon: Icons.report_problem,
            onTap: () {
              // Add navigation or logic
            },
          ),
          _buildDivider(),

          _subSectionTitle("Feedback:"),
          _actionTile(
            title: "Share your thoughts",
            icon: Icons.feedback,
            onTap: () {
              // Add navigation or logic
            },
          ),
          _buildDivider(),

          const SizedBox(height: 30),
          const Center(
            child: Text(
              "© 2025 College App. All rights reserved.",
              style: TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _featuresSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _subSectionTitle("App Features:"),
        _featureTile(
          icon: Icons.school,
          title: "College Search",
          description:
              "Easily find colleges by name, course, or location with smart filters.",
        ),
        _featureTile(
          icon: Icons.compare,
          title: "College Comparison",
          description:
              "Compare two colleges side-by-side based on key factors.",
        ),
        _featureTile(
          icon: Icons.assessment,
          title: "College Predictor",
          description:
              "Use your exam scores and preferences to get personalized suggestions.",
        ),
        _featureTile(
          icon: Icons.feedback,
          title: "Personal Counseling",
          description:
              "Yes, we care about your well-being. Please contact your college counselor or write to us at counseling@collegeapp.com. We’ll connect you with the right help.",
        ),
      ],
    );
  }

  Widget _featureTile({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Colors.teal),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _subSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }

  Widget _infoText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _actionTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Divider(color: Colors.grey, thickness: 0.8, height: 30);
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({required this.question, required this.answer, super.key});

  @override
  State<FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          leading: const Icon(Icons.question_answer, color: Colors.black),
          title: Text(
            widget.question,
            style: const TextStyle(
              fontSize: 19,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
          onTap: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
        ),
        if (_expanded)
          Padding(
            padding: const EdgeInsets.only(left: 52.0, right: 8, bottom: 10),
            child: Text(
              widget.answer,
              style: TextStyle(fontSize: 16, color: Colors.black, height: 1.4),
            ),
          ),
      ],
    );
  }
}
