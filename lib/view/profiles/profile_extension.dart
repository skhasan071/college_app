import 'package:college_app/constants/ui_helper.dart';
import 'package:college_app/view/profiles/choice_preferences.dart';
import 'package:college_app/view_model/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EducationPreferenceCards extends StatefulWidget {

  const EducationPreferenceCards({super.key});

  @override
  State<EducationPreferenceCards> createState() => _EducationPreferenceCardsState();
}

class _EducationPreferenceCardsState extends State<EducationPreferenceCards> {
  var pfpController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Card 1: Based on Preferences
        UiHelper.getCard(width: double.infinity, widget: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Based on your preferences',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CoursePreferencesPage(isFlow: false)));
                  }, icon: Icon(Icons.edit, size: 18),),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Education',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '${pfpController.profile.value!.interestedStreams!.join(", ")}, ${pfpController.profile.value!.preferredCourseLevel ?? ""}, ${pfpController.profile.value!.modeOfStudy ?? ""}',
                style: TextStyle(fontWeight: FontWeight.bold),
                softWrap: true, // This ensures wrapping
              ),
              const SizedBox(height: 12),
              const Text(
                'Interested Courses',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                pfpController.profile.value!.coursesInterested!.isEmpty
                    ? "No Courses selected yet"
                    : pfpController.profile.value!.coursesInterested!.join(", "),
                style: TextStyle(fontWeight: FontWeight.bold),
                softWrap: true,
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 18),
                  SizedBox(width: 4),
                  Text('${pfpController.profile.value!.state}, ${pfpController.profile.value!.city}'),
                  SizedBox(width: 16),
                  Icon(Icons.access_time, size: 18),
                  SizedBox(width: 4),
                  Text('${pfpController.profile.value!.studyingIn}'),
                ],
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CoursePreferencesPage(isFlow: false)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'View Full Preferences',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ],
          ),
        )),

        SizedBox(height: 10,),

        // Card 2: Current Study Status
        UiHelper.getCard(width: double.infinity, widget: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Studying In',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '12th - Passed',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'Passed In',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '2025',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ))
      ],
    );
  }
}
