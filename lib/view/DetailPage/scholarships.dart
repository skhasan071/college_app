import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';

class Scholarships extends StatelessWidget {
  const Scholarships({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 3,
        title: const Text(
          'Scholarship & Aid',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(color: Colors.grey.shade300),
                  child: const Center(
                    child: Text(
                      'College\nLogo',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    'Oxford University',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,

                border: Border.all(color: Colors.black),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Average Financial Aid',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\$52,030',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'per year',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Students receiving aid\n70%'),
                      Text('Average need met\n100%'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 16),

            const Text(
              'Available Scholarships',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildScholarshipTile(
              title: 'Merit Scholarship',
              subtitle: 'Up to \$25,000 per year',
              onTap: () {},
            ),
            _buildScholarshipTile(
              title: 'Need-Based Grant',
              subtitle: 'Based on financial need',
              onTap: () {},
            ),
            _buildScholarshipTile(
              title: 'Athletic Scholarship',
              subtitle: 'Full tuition coverage',
              onTap: () {},
            ),

            const SizedBox(height: 16),
            Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 16),

            const Center(
              child: Text(
                'Calculate Your Aid',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 6),
            const Center(
              child: Text(
                'Get an estimate of your financial aid package',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  const intent = AndroidIntent(
                    action: 'android.intent.action.MAIN',
                    category: 'android.intent.category.APP_CALCULATOR',
                  );
                  intent.launch();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(),
                ),
                child: const Text(
                  'Start Calculator',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScholarshipTile({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
