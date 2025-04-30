import 'package:college_app/services/college_services.dart';
import 'package:college_app/view/Filters&Compare/search_res.dart';
import 'package:college_app/view_model/themeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:college_app/view_model/searchController.dart';

import '../../model/college.dart';

class SelectionPage extends StatelessWidget {
  final controller = Get.put(SelectionController());
  var searchCtrl = TextEditingController();

  final List<String> states = [
    'Delhi',
    'Maharastra',
    'Benguluru',
    'Karnataka',
    'Kolkata',
    'Others',
  ];

  final List<String> streams = [
    'Engineering',
    'Management',
    'Arts',
    'Science',
    'Law',
    'Medicine',
    'Design',
    'Humanities',
  ];

  final List<String> countries = [
    'India',
    'USA',
    'Germany',
    'UK',
    'France',
    'Japan',
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final theme = ThemeController.to.currentTheme;
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),

                child: TextField(
                  controller: searchCtrl,
                  decoration: InputDecoration(
                    hintText: "Search here...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            List<College> clgs = await CollegeServices()
                                .searchColleges(
                                  searchText: searchCtrl.text.trim(),
                                  streams: controller.selectedStreams.toList(),
                                  states: controller.selectedLocations.toList(),
                                  countries:
                                      controller.selectedCountries.toList(),
                                );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchRes(clgs),
                              ),
                            );
                          },
                          child: Text(
                            "Search",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: theme.backgroundGradient,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: buildGridSection(
                  "Search by States",
                  states,
                  controller.selectedLocations,
                  controller.toggleLocation,
                  isGreyBox: true,
                ),
              ),
              SizedBox(height: 24),

              buildStreamSection("Search by Streams", streams),
              SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: theme.backgroundGradient,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: buildGridSection(
                  "Search by Country",
                  countries,
                  controller.selectedCountries,
                  controller.toggleCountry,
                  isGreyBox: true,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildGridSection(
    String title,
    List<String> items,
    RxSet<String> selectedItems,
    Function(String) onTap, {
    required bool isGreyBox,
  }) {
    return Obx(() {
      final theme = ThemeController.to.currentTheme;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1,
            children:
                items.map((item) {
                  final isSelected = selectedItems.contains(item);
                  return GestureDetector(
                    onTap: () => onTap(item),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            isSelected
                                ? Border.all(
                                  color: theme.filterSelectedColor,
                                  width: 2,
                                ) // Using current theme color
                                : null,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow:
                            isGreyBox
                                ? [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 4,
                                    offset: Offset(1, 2),
                                  ),
                                ]
                                : [],
                      ),
                      child: Text(
                        item,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      );
    });
  }

  Widget buildStreamSection(String title, List<String> items) {
    return Obx(() {
      final theme = ThemeController.to.currentTheme;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  items.map((item) {
                    final isSelected = controller.selectedStreams.contains(
                      item,
                    );
                    return GestureDetector(
                      onTap: () => controller.toggleStream(item),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? theme.filterSelectedColor
                                  : Colors.transparent,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.zero,
                        ),
                        child: Text(
                          item,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      );
    });
  }
}
