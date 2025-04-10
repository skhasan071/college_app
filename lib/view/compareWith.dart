import 'package:flutter/material.dart';
import 'package:college_app/constants/colors.dart';
import 'package:college_app/constants/ui_helper.dart';

class CompareWith extends StatelessWidget {
  const CompareWith({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> dummyColleges = List.generate(4, (index) {
      return {
        "name": "IIT Bombay",
        "location": "Bombay",
        "description":
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros elementum tristique.",
      };
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Compare. Decide. Succeed.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(height: 4),
            Text(
              "Compare With",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Clr.primaryBtnClr,
                fontSize: 33,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Side-by-side comparison to find your best fit.",
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const SizedBox(height: 22),
            Text(
              "Select From Shortlisted Colleges or\nSearch Other",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
                color: Clr.primaryBtnClr,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros.",
              style: TextStyle(fontSize: 15, color: Clr.primaryBtnClr),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Icon(Icons.search, size: 18, color: Clr.primaryBtnClr),
                        SizedBox(width: 6),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(fontSize: 13),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.sort, size: 16, color: Clr.primaryBtnClr),
                      SizedBox(width: 4),
                      Text("Sort by", style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),

            Expanded(
              child: ListView.separated(
                itemCount: dummyColleges.length,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final college = dummyColleges[index];
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Clr.primaryBtnClr),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey,
                              child: Icon(
                                Icons.image,
                                size: 27,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  college["name"]!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                  ),
                                ),
                                Text(
                                  college["location"]!,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.more_vert),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          college["description"]!,
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: UiHelper.getSecondaryBtn(
                              title: "Select to Compare",
                              callback: () {},
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: UiHelper.getPrimaryBtn(
                              title: "View Details",
                              callback: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
