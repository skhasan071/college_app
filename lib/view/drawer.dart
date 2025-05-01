import 'package:college_app/view/Setting&Support/settting.dart';
import 'package:college_app/view/Setting&Support/support.dart';
import 'package:college_app/view_model/themeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../view_model/controller.dart';

class DrawerWidget extends StatelessWidget {
  var controller = Get.put(Controller());
  GlobalKey<ScaffoldState> scaffoldKey;

  DrawerWidget(this.scaffoldKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final theme = ThemeController.to.currentTheme;

      return Drawer(
        child: Container(
          decoration: BoxDecoration(gradient: theme.backgroundGradient),
          child: SafeArea(
            child: Column(
              children: [
                // Top Section with Logo, Search, and Avatar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Logo',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cursive',
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                // Menu List
                Expanded(
                  child: ListView(
                    children: [
                      _buildTile(Icons.home, 'Home'),
                      _buildTile(
                        Icons.favorite_border,
                        'Shortlist/Favorites',
                        trailing: _badge('24'),
                        callback: () {
                          if (controller.isGuestIn.value) {
                            scaffoldKey.currentState?.closeDrawer();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please Login First"),
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.black,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          } else {
                            controller.navSelectedIndex.value = 4;
                            scaffoldKey.currentState?.closeDrawer();
                          }
                        },
                      ),
                      ExpansionTile(
                        leading: Icon(
                          Icons.account_balance,
                          color: Colors.black,
                        ),
                        iconColor: Colors.black,
                        title: Text(
                          'Management Colleges',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: [
                          _buildSubTile(
                            Icons.star,
                            'Top Ranked Colleges',
                            () {},
                          ),
                          _buildSubTile(
                            Icons.school,
                            'Find Colleges by Specialization',
                            () {},
                          ),
                          _buildSubTile(
                            Icons.info_outline,
                            'All about Management',
                            () {},
                          ),
                        ],
                      ),
                      _buildTile(
                        Icons.insights,
                        'Insights',
                        callback: () {
                          controller.navSelectedIndex.value = 2;
                          scaffoldKey.currentState?.closeDrawer();
                        },
                      ),
                      Divider(),
                      _buildTile(
                        Icons.support_agent,
                        'Support',
                        callback: () {
                          Get.to(() => SupportPage());
                        },
                      ),
                      _buildTile(
                        Icons.settings,
                        'Settings',
                        callback: () {
                          Get.to(() => SettingsPage());
                        },
                      ),
                    ],
                  ),
                ),
                Divider(),
                // Bottom User Info
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text('Name Surname'),
                  subtitle: Text('hello@gmail.com'),
                  trailing: Icon(Icons.more_vert),
                  onTap: () {
                    if (controller.isGuestIn.value) {
                      scaffoldKey.currentState?.closeDrawer();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please Login First"),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.black,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } else {
                      controller.navSelectedIndex.value = 5;
                      scaffoldKey.currentState?.closeDrawer();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTile(
    IconData icon,
    String title, {
    Widget? trailing,
    VoidCallback? callback,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      trailing: trailing,
      onTap: callback,
    );
  }

  Widget _buildSubTile(IconData icon, String title, callback) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 56, right: 16),
      leading: Icon(icon, size: 20, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: callback,
    );
  }

  Widget _badge(String count) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(count, style: TextStyle(fontSize: 12, color: Colors.white)),
    );
  }
}
