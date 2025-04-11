import 'package:flutter/material.dart';

class BlogPageDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Blog Title Section
              Text(
                'Blog title heading will go here',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Category • 5 min read',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                'Published on 11 Jan 2022',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 16),

              // Blog Image Section
              Container(
                color: Colors.grey[300],
                height: 200,
                child: Center(child: Icon(Icons.image, size: 50, color: Colors.white)),
              ),
              SizedBox(height: 16),

              // Blog Introduction Section
              Text(
                'Introduction',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Mi tincidunt elit, id quisque ligula ac diam, amet. Vel etiam suspendisse morbi eleifend faucibus eget vestibulum felis. Ductus quis montes, sit sit. Tellus aliquam enim urna, etiam. Mauris posuere vulputate arcu amet, vitae nisi, tellus tincidunt. At feugiat sapien varius id.',
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8,),
              Text(
                'Mi tincidunt elit, id quisque ligula ac diam, amet. Vel etiam suspendisse morbi eleifend faucibus eget vestibulum felis. Ductus quis montes, sit sit. Tellus aliquam enim urna, etiam. Mauris posuere vulputate arcu amet, vitae nisi, tellus tincidunt. At feugiat sapien varius id.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Picture Below Introduction
              Container(
                height: 200,
                color: Colors.grey[300],
                child: Center(child: Icon(Icons.image, size: 50, color: Colors.white)),
              ),
              SizedBox(height: 20),

              // Quote Section (scrollable container with border and shadow)
              Container(
                height: 200, // Fixed height for the scrollable quote section
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 3), // Shadow position
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '"Ipsum sit mattis nulla quam nulla. Gravida id gravida ac enim mauris id. Non pellentesque congue eget consectetur turpis. Sapien, dictum molestie sem Ipsum sit mattis nulla quam nulla. Gravida id gravida ac enim mauris id. Non pellentesque congue eget consectetur turpis. Sapien, dictum molestie sem Ipsum sit mattis nulla quam nulla. Gravida id gravida ac enim mauris id. Non pellentesque congue eget consectetur turpis. Sapien, dictum molestie sem tempor. Diam elit, orci, tincidunt aenean tempus."',
                      style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),


              // Conclusion Section
              Text(
                'Conclusion',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Morbi sed imperdiet in ipsum, adipiscing elit dui lectus. Tellus id scelerisque ultrices ultrices. Duis est sit sed neque nisl, blandit elit sagittis. Odioque tristique consequat quam sed. Nisl sit aliquet tristique augue nulla purus habitasse.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Contributors Section
              Text(
                'Contributors',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Column(
                children: [
                  contributorCard('Full Name', 'Job title, Company name'),
                  contributorCard('Full Name', 'Job title, Company name'),
                  contributorCard('Full Name', 'Job title, Company name'),
                ],
              ),
              SizedBox(height: 20),

              // Newsletter Section
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
