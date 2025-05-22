import 'package:college_app/services/user_services.dart'; // Ensure this import
import 'package:college_app/view/home_page.dart';
import 'package:college_app/view/profiles/choice_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:college_app/view_model/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/ui_helper.dart';
import '../../main.dart';
import '../../model/user.dart'; // adjust the path as needed

class CompleteProfilePage extends StatefulWidget {
  final bool isEditing;
  const CompleteProfilePage({super.key, this.isEditing = false});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  var profile = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    getFields();
  }

  final List<String> studyingItems = [
    'SSC',
    'HSC',
    'Engineering Colleges',
    'Management Colleges',
    'Business Schools',
    'Arts & Humanities Colleges',
    'Law Schools',
    'Medical Colleges',
    'Design Institutes',
  ];
  final List<String> states = [
    "Maharashtra",
    "Karnataka",
    "Telangana",
    "Uttar Pradesh",
    "Arunachal Pradesh",
  ];
  final List<String> cities = ['Mumbai', 'Pune'];
  String? studyingIn;
  String? state;
  String? city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.isEditing
                      ? "Update your Profile"
                      : "Complete your Profile",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.isEditing
                      ? "Update your details below."
                      : "Complete your details below.",
                  style: const TextStyle(color: Colors.black),
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
                  hint: "Mobile (include +91)",
                  controller: mobileController,
                  pre: const Icon(Icons.phone_outlined),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(13),
                  ],
                ),
                const SizedBox(height: 16),

                buildDropdown(
                  "Studying in",
                  (val) => studyingIn = val,
                  studyingItems,
                  profile.profile.value!.studyingIn,
                ),
                const SizedBox(height: 16),
                buildDropdown(
                  "State",
                  (val) => state = val,
                  states,
                  profile.profile.value!.state,
                ),
                const SizedBox(height: 16),
                buildDropdown(
                  "City You Live In",
                  (val) => city = val,
                  cities,
                  profile.profile.value!.city,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    UiHelper.getSecondaryBtn(
                      title: "Cancel",
                      callback: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 12),
                    UiHelper.getPrimaryBtn(
                      title: widget.isEditing ? "Update" : "Next",
                      callback: () async {
                        String name = nameController.text.trim();
                        String email = emailController.text.trim();
                        String phNo = mobileController.text.trim();

                        studyingIn ??= studyingItems[0];
                        state ??= states[0];
                        city ??= cities[0];

                        if (phNo.length != 13) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please enter a 10-digit mobile number",
                              ),
                              backgroundColor: Colors.purple,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }else if(!phNo.contains("+91")){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please enter valid Mobile Number",
                              ),
                              backgroundColor: Colors.purple,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          return;
                        }

                        // Proceed with updating profile
                        if (name.isNotEmpty &&
                            email.isNotEmpty &&
                            phNo.isNotEmpty &&
                            studyingIn != null &&
                            state != null &&
                            city != null) {

                          if(profile.userToken.value == ''){
                            profile.userToken.value = (await getToken()) ?? '';
                          }

                          Student? data =
                              await StudentService.addOrUpdateStudent(
                                token: profile.userToken.value,
                                mobileNumber: phNo,
                                studyingIn: studyingIn!,
                                city: city!,
                                state: state!,
                                name: name,
                                email: email,
                              );

                          if (data != null) {
                            print("Received: ${profile.userToken.value}");
                            if (widget.isEditing) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    "Profile Updated Successfully!",
                                  ),
                                  backgroundColor: Colors.black,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(profile.userToken.value)));
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CoursePreferencesPage(isFlow: true,),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Something Went Wrong, Retry..."),
                                backgroundColor: Colors.purple,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        } else {
                          if (name.isEmpty) {
                            showSnack(context, "Name is required");
                            return;
                          }
                          if (email.isEmpty) {
                            showSnack(context, "Email is required");
                            return;
                          }

                          if (phNo.isEmpty) {
                            showSnack(context, "Mobile number is required");
                            return;
                          }

                          if (studyingIn == null || studyingIn!.isEmpty) {
                            showSnack(
                              context,
                              "Please select what you are studying in",
                            );
                            return;
                          }

                          if (state == null || state!.isEmpty) {
                            showSnack(
                              context,
                              "Please select your state",
                            );
                            return;
                          }

                          if (city == null || city!.isEmpty) {
                            showSnack(context, "Please select your city");
                            return;
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(
    String label,
    Function(String?) onChanged,
    List<String> dropdownItems,
    val,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: dropdownItems.first,
          items:
              dropdownItems
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.zero),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  void showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.purple,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void getFields() {
    Student pfp = profile.profile.value!;
    nameController.text = pfp.name ?? '';
    emailController.text = pfp.email ?? '';
    mobileController.text = pfp.mobileNumber ?? "";
    studyingIn = pfp.studyingIn ?? studyingItems[0];
    state = pfp.state ?? states[0];
    city = pfp.city ?? cities[0];
  }

}
