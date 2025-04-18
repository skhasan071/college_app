import 'package:college_app/view/DetailPage/collegeDetail.dart';
import 'package:college_app/view/Filters&Compare/compareCollege.dart';
import 'package:flutter/material.dart';
import 'package:college_app/constants/colors.dart';
import 'package:college_app/constants/ui_helper.dart';
import 'package:college_app/model/college.dart';

class CompareWith extends StatelessWidget {
  final College clg;
  const CompareWith({super.key, required this.clg});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> dummyColleges = [
      {
        "name": "IIT Bombay",
        "state": "Maharashtra",
        "description":
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros elementum tristique.",
      },
      {
        "name": "IIT Delhi",
        "state": "Delhi",
        "description":
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros elementum tristique.",
      },
      {
        "name": "IIT Madras",
        "state": "Tamil Nadu",
        "description":
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros elementum tristique.",
      },
      {
        "name": "IIT Kanpur",
        "state": "Uttar Pradesh",
        "description":
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros elementum tristique.",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Choose with Confidence',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
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
                      border: Border.all(color: Colors.black),
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
                    border: Border.all(color: Colors.black),
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
            SizedBox(height: 15),
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
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.image,
                            size: 31,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          college["name"]!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                          ),
                        ),
                        Text(
                          college["state"]!,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          college["description"]!,
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: UiHelper.getSecondaryBtn(
                            title: "Select to Compare",
                            callback: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => CompareColleges(
                                        college: clg,
                                        clg: clg,
                                      ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: UiHelper.getPrimaryBtn(
                            title: "View Details",
                            callback: () {
                              Navigator.pop(context);
                            },
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
