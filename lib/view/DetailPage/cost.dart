import 'package:college_app/constants/ui_helper.dart';
import 'package:college_app/view_model/themeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Cost extends StatelessWidget {
  final String collegeId;
  final String collegeName;
  const Cost({super.key, required this.collegeId, required this.collegeName});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final theme = ThemeController.to.currentTheme;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 3,
          title: const Text(
            'Cost & Location',
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150,
                color: Colors.grey.shade200,
                child: const Center(
                  child: Icon(Icons.image, size: 60, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      collegeName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "450 Serra Mall, Stanford, CA 94305",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.directions),
                          label: Text("Directions"),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.share),
                          label: Text("Share"),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    Divider(color: Colors.grey, thickness: 0.5),
                    const SizedBox(height: 22),

                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        gradient: theme.backgroundGradient,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cost of Living",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildCostItem("Monthly Rent (1 BHK)", "\$2,800"),
                          _buildCostItem("Monthly Utilities", "\$150"),
                          _buildCostItem("Monthly Transport", "\$100"),
                          _buildCostItem("Monthly Groceries", "\$400"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Divider(color: Colors.grey, thickness: 0.5),
                    const SizedBox(height: 22),

                    const Text(
                      "Nearby Places",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildNearbyItem(
                      Icons.restaurant,
                      "Restaurants",
                      "25+ within 1 mile",
                    ),
                    const SizedBox(height: 16),
                    _buildNearbyItem(
                      Icons.local_cafe,
                      "Cafes",
                      "15+ within 1 mile",
                    ),
                    const SizedBox(height: 16),
                    _buildNearbyItem(
                      Icons.shopping_bag,
                      "Shopping",
                      "10+ within 2 miles",
                    ),
                    const SizedBox(height: 16),
                    _buildNearbyItem(
                      Icons.directions_transit,
                      "Public Transport",
                      "5 stations nearby",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildCostItem(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade500),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildNearbyItem(IconData icon, String title, String subtitle) {
    return Obx(() {
      final theme = ThemeController.to.currentTheme;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: theme.backgroundGradient,
          borderRadius: BorderRadius.circular(10),
          border: const Border(
            top: BorderSide(color: Colors.grey, width: 0.4),
            bottom: BorderSide(color: Colors.grey, width: 0.4),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.filterSelectedColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 25, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
