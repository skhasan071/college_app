import 'package:college_app/constants/ui_helper.dart';
import 'package:flutter/material.dart';

class EducationPreferenceCards extends StatelessWidget {
  const EducationPreferenceCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Card 1: Based on Preferences
        UiHelper.getCard(width: double.infinity, widget: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Expanded(
                    child: Text(
                      'Based on your preferences',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(Icons.edit, size: 18),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Education',
                style: TextStyle(color: Colors.grey),
              ),
              const Text(
                'Full Time, Management, PG',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Specialization',
                style: TextStyle(color: Colors.grey),
              ),
              const Text(
                'MBA (Finance), Entrepreneurship & Startups',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Icon(Icons.location_on_outlined, size: 18),
                  SizedBox(width: 4),
                  Text('India'),
                  SizedBox(width: 16),
                  Icon(Icons.access_time, size: 18),
                  SizedBox(width: 4),
                  Text('2026'),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'View Full Preferences',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ],
          ),
        )),

        SizedBox(height: 10,),

        // Card 2: Current Study Status
        UiHelper.getCard(width: double.infinity, widget: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Studying In',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '12th - Passed',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'Passed In',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '2025',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ))
      ],
    );
  }
}
