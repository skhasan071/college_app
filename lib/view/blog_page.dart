import 'package:college_app/view_model/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'blog_detail_page.dart';  // Import the detail page

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}


class _BlogPageState extends State<BlogPage> {
  List<Map<String, dynamic>> blogs = [];
  
  var controller = Get.put(Controller());

  // Fetch blogs from the backend
  Future<void> fetchBlogs() async {
    controller.isLoading.value = true;
    final response = await http.get(Uri.parse('http://localhost:8080/api/blogs'));  // Change to your backend URL

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData);
      blogs = List<Map<String, dynamic>>.from(responseData['blogs']);
      controller.isLoading.value = false;
    } else {
      print('Failed to load blogs');
      controller.isLoading.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBlogs();  // Fetch blogs when the page is loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
          ()=> controller.isLoading.value
              ? Center(child: CircularProgressIndicator())  // Show a loading indicator while fetching
              : blogs.isNotEmpty ? ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: BlogCard(
                  title: blogs[index]['title'],
                  category: blogs[index]['category'],
                  readingTime: blogs[index]['readingTime'],
                  description: blogs[index]['description'],
                  image: 'assets/gmail-logo.jpg',  // Use default image if none
                  blog: blogs[index],  // Pass the entire blog to the detail page
                ),
              );
            },
          ) : Center(child: Text("No Blogs Found", style: TextStyle(color: Colors.black, fontSize: 20,),),)
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  final String title;
  final String category;
  final String readingTime;
  final String description;
  final String image;
  final Map<String, dynamic> blog;

  BlogCard({
    required this.title,
    required this.category,
    required this.readingTime,
    required this.description,
    required this.image,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 1)],
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blog image
            Image.asset(image), // Replace with your image assets or URLs

            SizedBox(height: 16),

            // Category and reading time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category,
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  readingTime,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Blog title
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // Blog description
            Text(
              description,
              style: TextStyle(color: Colors.grey),
            ),

            SizedBox(height: 16),

            // Read more button
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogPageDetail(blog: blog),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Read more'),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
