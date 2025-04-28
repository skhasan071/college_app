import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Hostel extends StatefulWidget {
  final String collegeId; // Pass the selected collegeId from the previous screen

  const Hostel({required this.collegeId, super.key});

  @override
  State<Hostel> createState() => _HostelState();
}

class _HostelState extends State<Hostel> {
  bool isLoading = true;
  String errorMessage = "";
  String hostelName = "";
  List<String> hostelAmenities = [];
  List<String> campusAmenities = [];
  String hostelInfo = "";
  List<String> photos = [];  // To hold the photo URLs

  @override
  void initState() {
    super.initState();
    fetchHostelDetails();
  }

  // Fetch hostel data from the API
  Future<void> fetchHostelDetails() async {
    final url = 'https://tc-ca-server.onrender.com/api/colleges/hostel/${widget.collegeId}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        hostelName = data['hostelName'] ?? "Hostel Name Not Available";
        hostelAmenities = List<String>.from(data['hostelAmenities'] ?? []);
        campusAmenities = List<String>.from(data['campusAmenities'] ?? []);
        hostelInfo = data['hostelInfo'] ?? "No information available.";
        photos = List<String>.from(data['photos'] ?? []);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        errorMessage = "Error fetching hostel data.";
      });
    }
  }

  // Method to build the amenities list using recruiter chip widget
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Hostel & Campus Life",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loader while fetching
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage)) // Show error message
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Photos (if any)
            photos.isNotEmpty
                ? SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Image.network(
                      photos[index],
                      fit: BoxFit.cover,
                      height: 200,
                      width: 300,
                    ),
                  );
                },
              ),
            )
                : const SizedBox.shrink(),

            const SizedBox(height: 16),

            // Hostel Name
            Text(
              hostelName,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 22),

            // Hostel Amenities
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Hostel Amenities",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: hostelAmenities
                  .map((amenity) => _buildRecruiterChip(amenity))
                  .toList(),
            ),
            const SizedBox(height: 16),

            Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 22),

            // Campus Amenities
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Campus Amenities",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: campusAmenities
                  .map((amenity) => _buildRecruiterChip(amenity))
                  .toList(),
            ),
            const SizedBox(height: 16),

            Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 22),

            // Hostel Information
            Text(
              hostelInfo,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
