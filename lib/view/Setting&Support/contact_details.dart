import 'package:flutter/material.dart';

class ContactDetailsPage extends StatelessWidget {
  const ContactDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Talent Connect'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company Name
              Center(
                child: Text(
                  'Talent Connect',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Contact Information
              const Text(
                'Contact Information:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.phone, color: Colors.blue),
                title: Text('+1 (234) 567-890'),
              ),
              const ListTile(
                leading: Icon(Icons.email, color: Colors.blue),
                title: Text('contact@talentconnect.com'),
              ),
              const ListTile(
                leading: Icon(Icons.location_on, color: Colors.blue),
                title: Text('123 Talent St, City, Country'),
              ),
              const SizedBox(height: 20),
              // Contact Form (Optional)
              const Text(
                'Send Us a Message:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Your Message',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Submit Button
              ElevatedButton(
                onPressed: () {
                  // Handle form submission
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Message sent successfully!')),
                  );
                },
                child: const Text('Send Message'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
