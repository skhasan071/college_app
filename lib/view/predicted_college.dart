import 'package:flutter/material.dart';

class CollegeResultsPage extends StatefulWidget {
  const CollegeResultsPage({super.key});

  @override
  State<CollegeResultsPage> createState() => _CollegeResultPageState();
}

class _CollegeResultPageState extends State<CollegeResultsPage> {
  int selectedFilterIndex = 0;
  List<String> filters = ['View all', 'Filter 1', 'Filter 2', 'Filter 3', 'Filter 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Predict Your Rank. Find Your College.",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              const Text(
                "College Predictor",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              const Text(
                "Your personalized college recommendations based on your score.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list, color: Colors.black),
                      label: const Text("Filter", style: TextStyle(color: Colors.black)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 60),
                  SizedBox(
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text("Edit Rank", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 28),
              SizedBox(
                height: 36,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == selectedFilterIndex;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedFilterIndex = index;
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: isSelected ? Colors.black : Colors.grey[200],
                          foregroundColor: isSelected ? Colors.white : Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: Colors.black),
                          ),
                        ),
                        child: Text(filters[index]),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),
              // Placeholder for future card section
              Expanded(
                child: Center(
                  child: Text(
                    "[College Cards will appear here]",
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
