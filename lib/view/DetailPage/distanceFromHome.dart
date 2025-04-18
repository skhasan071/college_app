import 'package:flutter/material.dart';

class DistanceFromHometown extends StatelessWidget {
  const DistanceFromHometown({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Distance from Hometown",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 190,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text("Interactive Map View")),
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Distance",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "456 km",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Travel Time",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "6h 30m",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            const TravelOptionCard(
              icon: Icons.train,
              title: "By Train",
              subtitle: "4h 30m • From \$45",
            ),
            const TravelOptionCard(
              icon: Icons.directions_bus,
              title: "By Bus",
              subtitle: "6h 30m • From \$25",
            ),
            const SizedBox(height: 24),

            Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 16),
            // Nearby Places
            const Text(
              "Nearby Places",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(
                  child: NearbyPlaceCard(
                    title: "City Center",
                    distance: "2.5 km away",
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: NearbyPlaceCard(
                    title: "Shopping Mall",
                    distance: "3.8 km away",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(),
                ),
                onPressed: () {},
                child: const Text(
                  "Get Directions",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TravelOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const TravelOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
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
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class NearbyPlaceCard extends StatelessWidget {
  final String title;
  final String distance;

  const NearbyPlaceCard({
    super.key,
    required this.title,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: Text("Place Image")),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            distance,
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
