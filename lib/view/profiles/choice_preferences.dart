import 'package:college_app/main.dart';
import 'package:college_app/services/user_services.dart';
import 'package:college_app/view/SignUpLogin/FirstPage.dart';
import 'package:college_app/view/home_page.dart';
import 'package:college_app/view_model/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/ui_helper.dart';

class CoursePreferencesPage extends StatefulWidget {
  final bool isFlow;
  const CoursePreferencesPage({required this.isFlow, super.key});

  @override
  State<CoursePreferencesPage> createState() => _CoursePreferencesPageState();
}

class _CoursePreferencesPageState extends State<CoursePreferencesPage> {

  final List<String> streams = [
    'Engineering', 'Management', 'Arts', 'Science', 'Law',
    'Medicine', 'Design', 'Humanities'
  ];

  final List<String> courses = [
    "BBA/MBA(General)", "MBA(Finance)", "MBA(Marketing)", "MBA(HR)", "MBA(Operations)", "PGDM", "Entrepreneurship & Startups", "Business Analytics"
  ];


  final List<String> levels = ['UG', 'PG', 'Diploma/Certification'];
  final List<String> modes = ['Full-time', 'Part-time', 'Online', 'Distance learning'];
  final List<String> years = ['2025', '2026', 'Later'];

  Set<String> selectedStreams = {};
  Set<String> selectedCourses = {};
  String? selectedLevel;
  String? selectedMode;
  String? selectedYear;

  var pfpCtrl = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(pfpCtrl.userToken.value)), (route)=>false);
        return false;
      },
      child: Scaffold(

        backgroundColor: Colors.white,

        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Close Button
                  !widget.isFlow?
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(pfpCtrl.userToken.value)), (route)=>false);
                        },
                      ),
                    ) : SizedBox.shrink(),

                  const SizedBox(height: 12),
                  const Text("Course Preferences", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text("Choose preferences to explore colleges you prefer.",
                      style: TextStyle(color: Colors.black54)),
                  const SizedBox(height: 24),

                  _buildSectionTitle("Interested Streams"),
                  _buildChips(streams, selectedStreams, isMulti: true),

                  const SizedBox(height: 16),
                  _buildSectionTitle("Course(s) Interested In"),
                  _buildChips(courses, selectedCourses, isMulti: true),

                  const SizedBox(height: 16),
                  _buildSectionTitle("Preferred Course Level"),
                  _buildChips(levels, {selectedLevel}, isMulti: false, onChanged: (val) => setState(() => selectedLevel = val)),

                  const SizedBox(height: 16),
                  _buildSectionTitle("Mode of Study"),
                  _buildChips(modes, {selectedMode}, isMulti: false, onChanged: (val) => setState(() => selectedMode = val)),

                  const SizedBox(height: 16),
                  _buildSectionTitle("Preferred year of admission (optional)"),
                  _buildChips(years, {selectedYear}, isMulti: false, onChanged: (val) => setState(() => selectedYear = val)),

                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UiHelper.getSecondaryBtn(title: "Back", callback: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Firstpage()));
                      }),
                      UiHelper.getPrimaryBtn(title: "Next", callback: () async {

                        pfpCtrl.userToken.value = await getToken() ?? "";

                        if(pfpCtrl.userToken.value != ""){

                          pfpCtrl.profile.value!.interestedStreams = selectedStreams.toList();
                          pfpCtrl.profile.value!.coursesInterested = selectedCourses.toList();
                          pfpCtrl.profile.value!.preferredCourseLevel = selectedLevel ?? "UG";
                          pfpCtrl.profile.value!.modeOfStudy = selectedMode ?? "Full-Time";
                          pfpCtrl.profile.value!.preferredYearOfAdmission = selectedYear ?? "2025";
                          Map<String, dynamic>? data = await StudentService.saveCoursePreferences(token: pfpCtrl.userToken.value, coursesInterested: selectedCourses.toList(), interestedStreams: selectedStreams.toList(), modeOfStudy: selectedMode, preferredCourseLevel: selectedLevel, preferredYearOfAdmission: selectedYear);

                        }else{
                          pfpCtrl.interestedStreams.value = selectedStreams.toList();
                          pfpCtrl.coursesInterested.value = selectedCourses.toList();
                        }

                        if(widget.isFlow){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomePage(pfpCtrl.userToken.string)), (route) => false);
                        }else{
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(pfpCtrl.userToken.value)), (route) => false);
                        }
                      }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
    );
  }

  Widget _buildChips(List<String> options, Set<String?> selectedValues, {
    bool isMulti = false,
    Function(String)? onChanged,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((item) {
        final isSelected = selectedValues.contains(item);
        return ChoiceChip(
          label: Text(item),
          selected: isSelected,
          selectedColor: Colors.black,
          backgroundColor: Colors.white,
          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
          side: const BorderSide(color: Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          onSelected: (_) {
            setState(() {
              if (isMulti) {
                isSelected ? selectedValues.remove(item) : selectedValues.add(item);
              } else {
                selectedValues.clear();
                selectedValues.add(item);
                if (onChanged != null) onChanged(item);
              }
            });
          },
        );
      }).toList(),
    );
  }
}