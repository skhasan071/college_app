import 'package:college_app/view/profiles/profile_extension.dart';
import 'package:college_app/view_model/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfilePage extends StatelessWidget {

  ProfilePage({super.key});

  var profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.image, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Name Surname",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.email, size: 16),
                                SizedBox(width: 4),
                                Text("hello@relume.io"),
                              ],
                            ),
                            SizedBox(width: 16),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.phone, size: 16),
                                SizedBox(width: 4),
                                Text("1234567890"),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(Icons.location_on, size: 16),
                            SizedBox(width: 4),
                            Text("Delhi, India"),
                            SizedBox(width: 16),
                            Icon(Icons.female, size: 16),
                            SizedBox(width: 4),
                            Text("Female"),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text("D.O.B: July 1, 2000"),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_vert),
                ],
              ),
              const SizedBox(height: 20),
              Obx(
                  ()=> profileController.isFullProfileEnable.value ?
                  EducationPreferenceCards()
                      : ElevatedButton(
                    onPressed: () {
                      profileController.isFullProfileEnable.value = true;
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text("View Profile", style: TextStyle(color: Colors.white)),
                  ),
              ),
              const Divider(height: 40),
              const SettingsTile(icon: Icons.settings, title: "General Settings"),
              const SettingsTile(icon: Icons.contact_mail, title: "Contact Details"),
              const SettingsTile(icon: Icons.privacy_tip, title: "Privacy"),
              const Divider(height: 40),
              const SettingsTile(icon: Icons.support, title: "Support"),
              const SettingsTile(icon: Icons.logout, title: "Logout"),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const SettingsTile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        // Implement navigation or actions here
      },
    );
  }
}