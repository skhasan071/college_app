import 'package:college_app/services/college_services.dart';
import 'package:college_app/view/Filters&Compare/search_res.dart';
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
                            List<College> clgs = await CollegeServices().searchColleges(searchText: searchCtrl.text.trim(), streams: controller.selectedStreams.toList(), states: controller.selectedLocations.toList(), countries: controller.selectedCountries.toList());

                            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchRes(clgs)));
                          },
                          child: Text("Search", style: TextStyle(color: Colors.black),),
                      )
                    ],
                  )
                ),
              ),

            ),

            buildGridSection(
              "Search by States",
              states,
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
                          color: isSelected ? Colors.black : Colors.transparent,
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
