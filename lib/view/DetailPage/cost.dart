import 'package:college_app/constants/ui_helper.dart';
import 'package:flutter/material.dart';

class Cost extends StatelessWidget {
  const Cost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Cost & Location'),
        centerTitle: true,
        leading: const Icon(Icons.arrow_back),
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
                  const Text(
                    "Stanford University",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "450 Serra Mall, Stanford, CA 94305",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      UiHelper.getPrimaryBtn(
                        title: "Directions",
                        callback: () {},
                        icon: Icons.directions,
                      ),
                      SizedBox(width: 15),
                      UiHelper.getPrimaryBtn(
                        title: "Share",
                        callback: () {},
                        icon: Icons.share,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Cost of Living",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildCostItem("Monthly Rent (1 BHK)", "\$2,800"),
                  _buildCostItem("Monthly Utilities", "\$150"),
                  _buildCostItem("Monthly Transport", "\$100"),
                  _buildCostItem("Monthly Groceries", "\$400"),
                  const SizedBox(height: 24),
                  const Text(
                    "Nearby Places",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
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
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 25, color: Colors.black87),
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
  }
}
