import 'package:college_app/view_model/themeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ContactDetailsPage extends StatelessWidget {
  const ContactDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Obx(() {
      final theme = ThemeController.to.currentTheme;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Contact Talent Connect'),
          backgroundColor: theme.filterSelectedColor,
          foregroundColor: theme.filterTextColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Talent Connect',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: theme.filterSelectedColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Contact Information:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const ListTile(
                    leading: Icon(Icons.phone, color: Colors.black),
                    title: Text(
                      '+1 (234) 567-890',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(Icons.email, color: Colors.black),
                    title: Text(
                      'contact@talentconnect.com',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(Icons.location_on, color: Colors.black),
                    title: Text(
                      '123 Talent St, City, Country',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    'Send Us a Message:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // Name Field
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Your Name',
                      border: OutlineInputBorder(),
                    ),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Name is required'
                                : null,
                  ),
                  const SizedBox(height: 10),

                  // Email Field
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Your Email',
                      border: OutlineInputBorder(),
                    ),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Email is required'
                                : null,
                  ),
                  const SizedBox(height: 10),

                  // Message Field
                  TextFormField(
                    controller: messageController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: 'Your Message',
                      border: OutlineInputBorder(),
                    ),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Message is required'
                                : null,
                  ),
                  const SizedBox(height: 20),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.filterSelectedColor,
                        foregroundColor: theme.filterTextColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Message sent successfully!'),
                            ),
                          );
                          nameController.clear();
                          emailController.clear();
                          messageController.clear();
                        }
                      },
                      child: const Text('Send Message'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
