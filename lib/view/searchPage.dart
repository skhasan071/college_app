import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:college_app/view_model/searchController.dart';

class SelectionPage extends StatelessWidget {
  final controller = Get.put(SelectionController());

  final List<String> locations = [
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
    'Others',
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search here...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),

            buildGridSection(
              "Search by Location",
              locations,
              controller.selectedLocations,
              controller.toggleLocation,
              isGreyBox: true,
            ),
            SizedBox(height: 24),

            buildStreamSection("Search by Streams", streams),
            SizedBox(height: 24),

            buildGridSection(
              "Search by Country",
              countries,
              controller.selectedCountries,
              controller.toggleCountry,
              isGreyBox: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridSection(
    String title,
    List<String> items,
    RxSet<String> selectedItems,
    Function(String) onTap, {
    required bool isGreyBox,
  }) {
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
                        color: Colors.grey[300],
                        border:
                            isSelected
                                ? Border.all(color: Colors.black, width: 2)
                                : null,
                      ),
                      child: Text(item, style: TextStyle(color: Colors.black)),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }

  Widget buildStreamSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          color: Colors.grey[300],
          child: Obx(
            () => Wrap(
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
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.transparent,
                          border: Border.all(color: Colors.black),
                        ),
                        child: Text(
                          item,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
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
