import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Scholarships extends StatefulWidget {
  final String collegeId;
  final String collegeName;

  Scholarships({required this.collegeId, required this.collegeName, super.key});

  @override
  _ScholarshipsState createState() => _ScholarshipsState();
}

class _ScholarshipsState extends State<Scholarships> {
  late List<dynamic> scholarships = [];
  late double averageFinancialAid = 0.0;

  @override
  void initState() {
    super.initState();
    fetchScholarships();
  }
  Future<void> fetchScholarships() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/scholarships/${widget.collegeId}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Check if the scholarships key exists and has valid data
        if (data['scholarships'] != null && data['scholarships'].isNotEmpty) {
          var scholarshipsList = data['scholarships'][0]['scholarships'];

          setState(() {
            scholarships = scholarshipsList.map((scholarship) {
              return {
                'ScholarshipName': scholarship['ScholarshipName'] ?? 'No name provided',
                'ScholarshipMoney': scholarship['ScholarshipMoney'] ?? 0,
                'ScholarshipDescription': scholarship['ScholarshipDescription'] ?? 'No description provided',
              };
            }).toList();

            // Calculate the average financial aid (if needed)
            averageFinancialAid = calculateAverageFinancialAid(scholarships);
          });
        } else {
          setState(() {
            scholarships = []; // Empty list when no scholarships
          });
          print("No scholarships found for this college.");
        }
      } else {
        print('Failed to load scholarships');
      }
    } catch (error) {
      print('Error fetching scholarships: $error');
    }
  }




  double calculateAverageFinancialAid(List<dynamic> scholarships) {
    double totalAid = 0.0;
    int validScholarships = 0;

    scholarships.forEach((scholarship) {
      if (scholarship['ScholarshipMoney'] != null) {
        totalAid += scholarship['ScholarshipMoney'];
        validScholarships++;
      }
    });

    return validScholarships > 0 ? totalAid / validScholarships : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.collegeName  ??   "College Name"} - Scholarships & Aid'), // Display college name dynamically
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 3,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // College Name (Removed Logo)
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.collegeName ?? 'No College Name',   // Display college name here
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 16),

            // Average Financial Aid (if you have averageFinancialAid)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Average Financial Aid', style: TextStyle(fontSize: 16, color: Colors.black)),
                  const SizedBox(height: 8),
                  Text('\$${averageFinancialAid.toStringAsFixed(2)}', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const Text('per year', style: TextStyle(fontSize: 16, color: Colors.black)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Students receiving aid\n70%'),
                      Text('Average need met\n100%'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 16),

            // Available Scholarships
            const Text('Available Scholarships', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            scholarships.isNotEmpty
                ? ListView.builder(
              shrinkWrap: true,
              itemCount: scholarships.length,
              itemBuilder: (context, index) {
                return _buildScholarshipTile(
                  title: scholarships[index]['ScholarshipName'],
                  subtitle: '\$${scholarships[index]['ScholarshipMoney']} per year',
                  description: scholarships[index]['ScholarshipDescription'],
                );
              },
            )
                : const Center(child: Text("No scholarships found for this college")),
// Show message when no scholarships are available

            const SizedBox(height: 16),
            Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

Widget _buildScholarshipTile({required String title, required String subtitle, required String description}) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 6),
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 6,
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle),
          const SizedBox(height: 8),  // Space between money and description
          Text(
            description,  // Displaying the description
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Handle tap on each scholarship for more details or actions
      },
    ),
  );
}

