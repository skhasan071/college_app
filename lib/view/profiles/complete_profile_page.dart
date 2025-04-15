import 'package:college_app/model/user.dart';
import 'package:college_app/services/user_services.dart';
import 'package:college_app/view/profiles/choice_preferences.dart';
import 'package:college_app/view_model/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constants/ui_helper.dart';// adjust the path as needed

class CompleteProfilePage extends StatelessWidget {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  var profile = Get.find<ProfileController>();

  final List<String> studyingItems = ["SSC","HSC"];
  final List<String> passingYearItems = ["2000","2001","2002","2003","2004"];
  final List<String> cities = ['Mumbai', 'Pune'];
  String? studyingIn;
  String? passedIn;
  String? city;

  CompleteProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    getFields();

    return Scaffold(

      backgroundColor: Colors.white,

      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const SizedBox(height: 16),
              const Text(
                "Complete your Profile",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 8),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros.",
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 24),

              const Text("Enter your name"),
              const SizedBox(height: 8),
              UiHelper.getTextField(hint: "Name", controller: nameController),
              const SizedBox(height: 16),

              const Text("Enter your email *"),
              const SizedBox(height: 8),
              UiHelper.getTextField(
                hint: "Email",
                controller: emailController,
                pre: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 16),

              const Text("Enter your mobile number *"),
              const SizedBox(height: 8),
              UiHelper.getTextField(
                hint: "Mobile",
                controller: mobileController,
                pre: const Icon(Icons.phone_outlined),
              ),
              const SizedBox(height: 16),

              buildDropdown("Studying in", (val) => studyingIn = val, studyingItems, profile.profile.value!.studyingIn),
              const SizedBox(height: 16),
              buildDropdown("Passed In", (val) => passedIn = val, passingYearItems, profile.profile.value!.passedIn),
              const SizedBox(height: 16),
              buildDropdown("City You Live In", (val) => city = val, cities, profile.profile.value!.city),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  UiHelper.getSecondaryBtn(title: "Cancel", callback: () {
                    Navigator.pop(context);
                  }),
                  const SizedBox(width: 12),
                  UiHelper.getPrimaryBtn(title: "Next", callback: () async {

                    String name = nameController.text.trim();
                    String email = emailController.text.trim();
                    String phNo = mobileController.text.trim();

                    if(name.isNotEmpty && email.isNotEmpty && phNo.isNotEmpty && studyingIn != null && passedIn != null && city != null){

                      print(profile.userToken.value);

                      Map<String, dynamic>? data = await StudentService.addOrUpdateStudent(token: profile.userToken.value, mobileNumber: phNo, studyingIn: studyingIn!, city: city!, passedIn: passedIn!);
                      if(data != null){

                        profile.profile.value = Student.fromMap(data);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CoursePreferencesPage()));

                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Something Went Wrong, Retry..."),
                            backgroundColor: Colors.purple,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }

                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Check for internet Connection"),
                          backgroundColor: Colors.purple,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }

                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(String label, Function(String?) onChanged, List<String> dropdownItems, val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: dropdownItems.first,
          items: dropdownItems
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.zero),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2))
          ),
        ),
      ],
    );
  }

  void getFields() {
    Student pfp = profile.profile.value!;
    nameController.text = pfp.name;
    emailController.text = pfp.email;
    mobileController.text = pfp.mobileNumber ?? "";
  }
}
