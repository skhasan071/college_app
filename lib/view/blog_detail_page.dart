import 'package:flutter/material.dart';

class BlogPageDetail extends StatelessWidget {
  final Map<String, dynamic> blog;  // Blog data passed from the list page

  BlogPageDetail({required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Detail'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // Go back to the blog list page
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // "All Posts" link
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back to the blog list
                },
                child: Text(
                  'All Posts',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),

              SizedBox(height: 8),

              // Category and reading time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    blog['category'] ?? 'Category',  // Use a default value if category is null
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    blog['readingTime'] ?? '5 min read',  // Default reading time
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 8),

              // Blog title and publish date
              Text(
                blog['title'] ?? 'Blog title heading will go here',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Published on ${blog['publishedDate'] ?? 'N/A'}',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 16),

              // Blog Image Section
              Container(
                color: Colors.grey[300],
                height: 200,
                child: blog['image'] != null
                    ? Image.asset(blog['image'])  // Load image from assets
                    : Image.asset('assets/default-image.jpg'),  // Default image if none
              ),
              SizedBox(height: 16),

              // Content Sections
              for (var section in blog['content']) buildContentSection(section),

              SizedBox(height: 20),

              // Contributors Section
              if (blog['contributors'] != null) ...[
                Text(
                  'Contributors',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Column(
                  children: [
                    for (var contributor in blog['contributors'])
                      contributorCard(contributor['name'], contributor['title']),
                  ],
                ),
              ],

              // Static Subscribe Section
              SizedBox(height: 40),
              Text(
                'Subscribe to our newsletter',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros elementum tristique.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                child: Text('Subscribe'),
              ),
              SizedBox(height: 20),

              // Share Section
              Text(
                'Share',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.link),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build each content section dynamically based on its type
  Widget buildContentSection(Map<String, dynamic> section) {
    switch (section['type']) {
      case 'bold':
        return Text(
          section['content']!,
          style: TextStyle(fontWeight: FontWeight.bold),
        );
      case 'scrollable':
        return SingleChildScrollView(
          child: Text(section['content']!),
        );
      default:
        return Text(section['content']!);
    }
  }

  // Contributor Card Widget
  Widget contributorCard(String name, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, color: Colors.black),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
