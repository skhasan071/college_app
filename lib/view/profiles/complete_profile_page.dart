import 'package:flutter/material.dart';
import '../../constants/ui_helper.dart';// adjust the path as needed

class CompleteProfilePage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  final List<String> studyingItems = ["Select One","SSC","HSC"];
  final List<String> passingYearItems = ['Select one...', "2000","2001","2002","2003","2004"];
  final List<String> cities = ['Select one...', 'Mumbai', 'Pune'];
  String? studyingIn;
  String? passedIn;
  String? city;

  CompleteProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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

              buildDropdown("Studying in", (val) => studyingIn = val, studyingItems),
              const SizedBox(height: 16),
              buildDropdown("Passed In", (val) => passedIn = val, passingYearItems),
              const SizedBox(height: 16),
              buildDropdown("City You Live In", (val) => city = val, cities),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  UiHelper.getSecondaryBtn(title: "Cancel", callback: () {
                    Navigator.pop(context);
                  }),
                  const SizedBox(width: 12),
                  UiHelper.getPrimaryBtn(title: "Next", callback: () {
                    // TODO: Handle form submission
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(String label, Function(String?) onChanged, List<String> dropdownItems) {
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
}
