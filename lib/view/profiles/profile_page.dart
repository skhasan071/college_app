import 'package:college_app/view/SignUpLogin/FirstPage.dart';
import 'package:college_app/view/Setting&Support/policy&privacy.dart';
import 'package:college_app/view/Setting&Support/settting.dart';
import 'package:college_app/view/Setting&Support/support.dart';
import 'package:college_app/view/profiles/profile_extension.dart';
import 'package:college_app/view_model/profile_controller.dart';
import 'package:college_app/view_model/themeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../view_model/controller.dart';
import '../Setting&Support/contact_details.dart';
import 'complete_profile_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  var profileController = Get.put(ProfileController());
  var controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final theme = ThemeController.to.currentTheme;
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
                          Text(
                            profileController.profile.value!.name!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Add the Edit button beside the name
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // Navigate to the CompleteProfilePage for editing
                                Get.to(
                                  () => CompleteProfilePage(isEditing: true),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.email, size: 16),
                                  SizedBox(width: 4),
                                  Text(profileController.profile.value!.email!),
                                ],
                              ),
                              SizedBox(width: 16),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.phone, size: 16),
                              SizedBox(width: 4),
                              Text(
                                profileController.profile.value!.mobileNumber
                                    .toString(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16),
                              SizedBox(width: 4),
                              Text(profileController.profile.value!.city ?? ""),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Obx(
                  () =>
                      profileController.isFullProfileEnable.value
                          ? EducationPreferenceCards()
                          : ElevatedButton(
                            onPressed: () {
                              profileController.isFullProfileEnable.value =
                                  true;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: const Text(
                              "View Profile",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                ),
                const Divider(height: 40),
                SettingsTile(
                  icon: Icons.settings,
                  title: "General Settings",
                  onTap: () {
                    Get.to(() => SettingsPage());
                  },
                ),

                SettingsTile(
                  icon: Icons.contact_mail,
                  title: "Contact Details",
                  onTap: () {
                    Get.to(() => ContactDetailsPage());
                  },
                ),
                SettingsTile(
                  icon: Icons.privacy_tip,
                  title: "Privacy",
                  onTap: () {
                    Get.to(() => PrivacyPolicyPage());
                  },
                ),
                const Divider(height: 40),
                SettingsTile(
                  icon: Icons.support,
                  title: "Support",
                  onTap: () {
                    Get.to(() => SupportPage());
                  },
                ),
                SettingsTile(
                  icon: Icons.logout,
                  title: "Logout",
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: theme.backgroundGradient,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Logout",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Are you sure you want to Logout?",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () => Navigator.pop(context),
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          side: BorderSide(
                                            color: theme.filterSelectedColor,
                                          ),
                                        ),
                                        child: Text(
                                          "No",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      ElevatedButton(
                                        onPressed: () async {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Firstpage(),
                                            ),
                                            (Route<dynamic> route) => false,
                                          );
                                          await delToken("");
                                          controller.navSelectedIndex.value = 0;
                                          profileController.userToken("");
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              theme.filterSelectedColor,
                                          foregroundColor:
                                              theme.filterTextColor,
                                          side: BorderSide(
                                            color: theme.filterSelectedColor,
                                          ),
                                        ),
                                        child: Text("Yes"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Function to save the token
  Future<void> delToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
