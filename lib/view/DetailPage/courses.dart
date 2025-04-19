import 'package:college_app/services/college_services.dart';
import 'package:flutter/material.dart';
import 'package:college_app/model/course.dart';
import 'package:get/get.dart';

class Courses extends StatefulWidget {

  String uid;

  Courses(this.uid, {super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    getCourse();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          title: const Text(
            'Courses & Fees',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCollegeLogo(),
            const SizedBox(height: 10),

            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 0.4),
                  bottom: BorderSide(color: Colors.grey, width: 0.4),
                ),
              ),
              child: TabBar(
                isScrollable: true,
                labelColor: Colors.white,
                tabAlignment: TabAlignment.start,
                unselectedLabelColor: Colors.black,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                indicator: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                ),
                tabs:
                    [
                      'All Courses',
                          'Engineering',
                          'Medical',
                          'Business',
                          'Arts',
                        ]
                        .map(
                          (title) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 2,
                            ),
                            child: Tab(child: Text(title)),
                          ),
                        )
                        .toList(),
              ),
            ),

            const SizedBox(height: 10),
            courses.isNotEmpty ? Expanded(
              child: TabBarView(
                children: [
                  _buildCourseList(courses),
                  _buildCourseList(courses),
                  _buildCourseList(courses),
                  _buildCourseList(courses),
                  _buildCourseList(courses),
                ],
              ),
            ) : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("No Course Offered", style: TextStyle(color: Colors.black, fontSize: 20),),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollegeLogo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(color: Colors.grey.shade300),
            child: const Center(
              child: Text(
                'College\nLogo',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // 🔥 Wrap with Expanded
          Expanded(
            child: Text(
              'Oxford University',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseList(List<Course> courses) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children:
            courses
                .map(
                  (course) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildCourseCard(
                      courseName: course.courseName,
                      duration: course.duration,
                      fees: '\$${course.fees}',
                      eligibility: course.examType,
                      intake: 'Sep 2025',
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildCourseCard({
    required String courseName,
    required String duration,
    required String fees,
    required String eligibility,
    required String intake,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  courseName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(duration, style: const TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildCourseDetail('Annual Fees', fees),
          _buildCourseDetail('Eligibility', eligibility),
          _buildCourseDetail('Next Intake', intake),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              onPressed: () {},
              child: const Text(
                'Apply Now',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    );
  }

  getCourse() async {
    courses = await CollegeServices.getCoursesByCollege(widget.uid);
    setState(() {});
  }

}
