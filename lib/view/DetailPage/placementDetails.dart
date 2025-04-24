import 'package:college_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:college_app/model/placement.dart';

class PlacementDetails extends StatefulWidget {
  final String collegeId;
  const PlacementDetails({super.key, required this.collegeId});

  @override
  State<PlacementDetails> createState() => _PlacementDetailsState();
}

class _PlacementDetailsState extends State<PlacementDetails> {
  late Placement placementData;
  bool isLoading = true; // Loading state for the page
  String errorMessage = ""; // To show an error message if data isn't found

  @override
  void initState() {
    super.initState();
    fetchPlacementData();
  }

  Future<void> fetchPlacementData() async {
    final url = 'http://localhost:8080/api/colleges/placement/${widget.collegeId}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Check if the data exists and assign it to placementData
      if (data.isNotEmpty) {
        setState(() {
          placementData = Placement.fromJson(data[0]);  // Assuming the response is an array and we take the first item
          isLoading = false; // Stop showing loader
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = "No placement data available for this college."; // Set error message if no data
        });
      }
    } else {
      setState(() {
        isLoading = false;
        errorMessage = "Error fetching placement data."; // Set error message if there is an API error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text(
          'Placement Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.share),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())  // Show loader while loading data
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (errorMessage.isNotEmpty) // If error message exists, show it
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            if (errorMessage.isEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard(context, 'Average Package', placementData.averagePackage),
                  _buildStatCard(context, 'Highest Package', placementData.highestPackage),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard(context, 'Placement Rate', placementData.placementRate),
                  _buildStatCard(context, 'Number of Companies Visited', placementData.numberOfCompanyVisited),
                ],
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.grey, thickness: 0.5),
              const SizedBox(height: 22),
              const Text(
                'Package Distribution',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(height: 12),
              _buildPackageBar('Above 20 LPA', double.parse(placementData.aboveTwenty) / 100),
              _buildPackageBar('15-20 LPA', double.parse(placementData.fifteenToTwenty) / 100),
              _buildPackageBar('10-15 LPA', double.parse(placementData.tenToFifteen) / 100),
              _buildPackageBar('5-10 LPA', double.parse(placementData.fiveToTen) / 100),
              const SizedBox(height: 16),
              Divider(color: Colors.grey, thickness: 0.5),
              const SizedBox(height: 22),
              const Text(
                'Top Recruiters',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 18,
                runSpacing: 16,
                children: placementData.companiesVisited.map((company) {
                  return _buildRecruiterChip(company);
                }).toList(),
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.grey, thickness: 0.5),
              const SizedBox(height: 22),
              const Text(
                'Recent Placements',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(height: 12),
              Column(
                children: placementData.recentPlacements.map<Widget>((placement) {
                  RegExp regExp = RegExp(r'^(.*?)(?:\s*-\s*(.*))$');
                  var match = regExp.firstMatch(placement);
                  if (match != null) {
                    var name = match.group(1);
                    var package = match.group(2);
                    return _buildRecentPlacement(name!, package!);
                  }
                  return SizedBox.shrink();
                }).toList(),
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value) {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 25,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.grey.shade200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageBar(String label, double percent) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 80,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 13,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: percent,
                    child: Container(
                      height: 13,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${(percent * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildRecruiterChip(String label) {
    return Container(
      width: 100,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }

  Widget _buildRecentPlacement(String name, String package) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: const CircleAvatar(
          radius: 35,
          child: Icon(Icons.person, size: 28),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(package),
      ),
    );
  }
}
