import 'package:college_app/services/college_services.dart';
import 'package:college_app/view_model/themeController.dart';
import 'package:flutter/material.dart';
import 'package:college_app/model/course.dart';
import 'package:get/get.dart';

class Courses extends StatefulWidget {
  final String uid;
  Courses(this.uid, {super.key, required this.collegeImage, required this.collegeName});
  final String collegeImage;
  final String collegeName;


  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  List<Course> main_courses = [];
  List<Course> filter_courses = [];
  List<Course> eng_courses = [];
  List<Course> med_courses = [];
  List<Course> arts_courses = [];
  List<Course> business_courses = [];


  @override
  void initState() {
    super.initState();
    getCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final theme = ThemeController.to.currentTheme;
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
            backgroundColor: Colors.white,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCollegeLogo(),
              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
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
                    color: theme.filterSelectedColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  tabs:
                      [
                            'All Courses',
                            'Engineering',
                            'Medical',
                            'Management',
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

              filter_courses.isNotEmpty
                  ? Expanded(
                    child: TabBarView(
                      children: [
                        ListView.builder(itemBuilder: (context, index){

                          Course course = filter_courses[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildCourseCard(
                              courseName: course.courseName,
                              duration: course.duration,
                              fees: '\$${course.fees}',
                              eligibility: course.examType,
                              intake: 'Sep 2025',
                            ),
                          );

                        }, itemCount: filter_courses.length, shrinkWrap: true,),
                        ListView.builder(itemBuilder: (context, index){

                          Course course = eng_courses[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildCourseCard(
                              courseName: course.courseName,
                              duration: course.duration,
                              fees: '\$${course.fees}',
                              eligibility: course.examType,
                              intake: 'Sep 2025',
                            ),
                          );

                        }, itemCount: eng_courses.length, shrinkWrap: true,),
                        ListView.builder(itemBuilder: (context, index){

                          Course course = med_courses[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildCourseCard(
                              courseName: course.courseName,
                              duration: course.duration,
                              fees: '\$${course.fees}',
                              eligibility: course.examType,
                              intake: 'Sep 2025',
                            ),
                          );

                        }, itemCount: med_courses.length, shrinkWrap: true,),
                        ListView.builder(itemBuilder: (context, index){

                          Course course = business_courses[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildCourseCard(
                              courseName: course.courseName,
                              duration: course.duration,
                              fees: '\$${course.fees}',
                              eligibility: course.examType,
                              intake: 'Sep 2025',
                            ),
                          );

                        }, itemCount: business_courses.length, shrinkWrap: true,),
                        ListView.builder(itemBuilder: (context, index){

                          Course course = arts_courses[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildCourseCard(
                              courseName: course.courseName,
                              duration: course.duration,
                              fees: '\$${course.fees}',
                              eligibility: course.examType,
                              intake: 'Sep 2025',
                            ),
                          );

                        }, itemCount: arts_courses.length, shrinkWrap: true,),
                      ]
                    ),
                  )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "No Course Offered",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
            ],
          ),
        ),
      );
    });
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
            child:  Center(
              child: Image.network(
                widget.collegeImage,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            ),
          ),
          const SizedBox(width: 12),

          // 🔥 Wrap with Expanded
          Expanded(
            child: Text(
              widget.collegeName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
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
    return Obx(() {
      final theme = ThemeController.to.currentTheme;
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
                  backgroundColor: theme.filterSelectedColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
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
    });
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
    main_courses = await CollegeServices.getCoursesByCollege(widget.uid);
    filter_courses = main_courses;
    eng_courses = getFiltered(filter: "Engineering");
    med_courses = getFiltered(filter: "Medical");
    arts_courses = getFiltered(filter: "Arts");
    business_courses = getFiltered(filter: "management");
    setState(() {});
  }

  List<Course> getFiltered({required String filter}){

    List<Course> temp = [];

    for(Course course in main_courses){
      if(course.category.toLowerCase() == filter.toLowerCase()){
        temp.add(course);
      }
    }

    return temp;

  }

}
