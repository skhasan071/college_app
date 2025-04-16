import 'package:college_app/view/blog_detail_page.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  final List<Map<String, String>> blogs = [
    {
      'title': 'Blog title heading will go here',
      'category': 'Category',
      'readingTime': '5 min read',
      'description':
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros.',
      'image': 'assets/gmail-logo.jpg',
    },
    {
      'title': 'Another blog title heading will go here',
      'category': 'Category',
      'readingTime': '6 min read',
      'description':
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros.',
      'image': 'assets/gmail-logo.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Blog description header
                Text(
                  'Describe what your blog is about',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 16),
                Text(
                  'Featured blog posts',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
          
                // List of blog cards
                ListView.builder(
                  itemCount: blogs.length,
                  itemBuilder: (context, index) {
                    return BlogCard(
                      title: blogs[index]['title']!,
                      category: blogs[index]['category']!,
                      readingTime: blogs[index]['readingTime']!,
                      description: blogs[index]['description']!,
                      image: blogs[index]['image']!,
                    );
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
        ),
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

  BlogCard({
    required this.title,
    required this.category,
    required this.readingTime,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)],
        borderRadius: BorderRadius.circular(20)
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
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => BlogPageDetail(),
                ),);
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
