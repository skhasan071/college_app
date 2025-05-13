import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:college_app/view_model/controller.dart';

import '../model/college.dart';
import '../services/college_services.dart';

class CollegePredictorPage extends StatefulWidget {
  const CollegePredictorPage({super.key});

  @override
  State<CollegePredictorPage> createState() => _CollegePredictorScreenState();
}

class _CollegePredictorScreenState extends State<CollegePredictorPage> {
  String? selectedState = "Select";
  String? selectedCategory = "Select";
  String? selectedExam = "Select";
  String? selectedRankType = "Select";
  String rank = '';

  var controller = Get.find<Controller>();

  final List<String> rankTypes = ['Percentile', "Rank"];
  final List<String> states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Delhi',
    'Jammu and Kashmir',
    'Ladakh',
    'Puducherry',
    'Chandigarh',
    'Andaman and Nicobar Islands',
    'Lakshadweep',
  ];

  final List<String> exams = [
    "JEE",
    "MHT-CET",
    "CET",
    "NEET",
    "BITSAT",
    "VITEEE",
    "Other"
  ];

  final List<String> categories = [
    'General',
    'OBC',
    'SC',
    'ST',
    'EWS',
    'PWD',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    selectedExam = "Select";
    selectedCategory = "Select";
    selectedRankType = "Select";
    rank = '0';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your Score. Your College.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "College Predictor",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Discover the colleges where you have the best chance of admission based on your scores.",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 23),

              _buildLabel("Select your Exam"),
              _buildDropdown(selectedExam, (value) {
                setState(() => selectedExam = value);
              }, exams),

              _buildLabel("Select your State"),
              _buildDropdown(selectedState, (value) {
                setState(() => selectedState = value);
              }, states),

              _buildLabel("Select your category"),
              _buildDropdown(selectedCategory, (value) {
                setState(() => selectedCategory = value);
              }, categories),

              _buildLabel("Select your Rank Type"),
              _buildDropdown(selectedRankType, (value) {
                setState(() => selectedRankType = value);
              }, rankTypes),

              const SizedBox(height: 14),

              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  hintText: "# Enter your rank / percentile",
                ),
                onChanged: (val) => rank = val,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6, // 60% width
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Check if all fields are filled and not set to "Select"
                      if (selectedExam == "Select" ||
                          selectedState == "Select" ||
                          selectedCategory == "Select" ||
                          selectedRankType == "Select" ||
                          rank.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Please fill all fields before proceeding.",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.black,
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 4),
                          ),
                        );
                        return;
                      }

                      // Check if the selected exam and state match
                      if (selectedExam == "MHT-CET" && selectedState != "Maharashtra") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "MHT-CET is not valid for ${selectedState ?? 'this state'}. Please select Maharashtra or change exam.",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.black,
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 4),
                          ),
                        );
                        return; // Don't proceed
                      }

                      List<College> colleges = await CollegeServices.predictColleges(
                        examType: selectedExam!,
                        category: selectedCategory!,
                        rankType: selectedRankType!,
                        rankOrPercentile: rank,
                        state: selectedState!,
                      );

                      controller.predictedClg.value = colleges;
                      controller.navSelectedIndex.value = 6;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // No curve
                      ),
                    ),
                    child: const Text(
                      "Get Colleges",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String? selectedValue,
      ValueChanged<String?> onChanged,
      List<String> list,
      ) {
    return DropdownButtonFormField<String>(
      value: selectedValue, // Default value is set to the selectedValue
      items: [
        // Add a "Select" option as the first item in the list
        DropdownMenuItem(value: "Select", child: Text("Select")),
        ...list.map((opt) {
          return DropdownMenuItem(value: opt, child: Text(opt));
        }).toList(),
      ],
      onChanged: onChanged,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 6,
          ), // Bold black border
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
