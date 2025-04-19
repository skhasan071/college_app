import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'blog_detail_page.dart';  // Import the detail page

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}


class _BlogPageState extends State<BlogPage> {
  List<Map<String, dynamic>> blogs = [];

  // Fetch blogs from the backend
  Future<void> fetchBlogs() async {
    final response = await http.get(Uri.parse('http://localhost:4000/api/blogs'));  // Change to your backend URL

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        blogs = List<Map<String, dynamic>>.from(responseData['blogs']);
      });
    } else {
      print('Failed to load blogs');
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
      appBar: AppBar(
        title: Text('Blog List'),
      ),
      body: blogs.isEmpty
          ? Center(child: CircularProgressIndicator())  // Show a loading indicator while fetching
          : ListView.builder(
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          return BlogCard(
            title: blogs[index]['title'],
            category: blogs[index]['category'],
            readingTime: blogs[index]['readingTime'],
            description: blogs[index]['description'],
            image: blogs[index]['image'] ?? 'assets/default-image.jpg',  // Use default image if none
            blog: blogs[index],  // Pass the entire blog to the detail page
          );
        },
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
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)],
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
