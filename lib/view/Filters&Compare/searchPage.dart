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

  // Countries
  final List<String> countries = [
    'India',
    'USA',
    'Germany',
    'UK',
    'France',
    'Japan',
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

  // Mapping of countries to their states
  final Map<String, List<String>> countryStates = {
    'India': ['Delhi', 'Maharashtra', 'Gujarat', 'Karnataka', 'Kolkata'],
    'USA': ['California', 'Texas', 'Florida', 'New York'],
    'Germany': ['Berlin', 'Hamburg', 'Munich'],
    'UK': ['England', 'Scotland', 'Wales'],
    'France': ['Paris', 'Lyon', 'Marseille'],
    'Japan': ['Tokyo', 'Osaka', 'Kyoto'],
  };

  // Initially display all states (this will update based on selected country)
  RxList<String> displayedStates = RxList<String>([]);

   SelectionPage({super.key});

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
                            style: TextStyle(color: theme.filterSelectedColor),
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
                  "Search by Country",
                  countries,
                  controller.selectedCountries,
                  controller.toggleCountry,
                  isGreyBox: true,
                ),
              ),
              SizedBox(height: 24),

              // Display states only after a country is selected
              Obx(() {
                if (controller.selectedCountries.isNotEmpty) {
                  // Clear the displayed states list
                  displayedStates.clear();
                  // Loop through all selected countries and add their states to displayedStates
                  for (String country in controller.selectedCountries) {
                    displayedStates.addAll(countryStates[country] ?? []);
                  }
                  // Ensure unique states are displayed
                  displayedStates = RxList<String>(
                    displayedStates.toSet().toList(),
                  );
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: theme.backgroundGradient,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: buildGridSection(
                      "Search by States",
                      displayedStates,
                      controller.selectedLocations,
                      controller.toggleLocation,
                      isGreyBox: true,
                    ),
                  );
                } else {
                  return Container();
                }
              }),

              SizedBox(height: 24),

              buildStreamSection("Search by Streams", streams),
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
    final theme = ThemeController.to.currentTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Obx(
          () => GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
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
                                )
                                : null,
                      ),
                      child: Text(
                        item,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }

  Widget buildStreamSection(String title, List<String> items) {
    final theme = ThemeController.to.currentTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? theme.filterSelectedColor
                                  : Colors.transparent,
                          border: Border.all(color: Colors.black),
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
        ),
      ],
    );
  }
}
