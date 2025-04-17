import 'package:flutter/material.dart';

class Hostel extends StatefulWidget {
  const Hostel({super.key});

  @override
  State<Hostel> createState() => _HostelState();
}

class _HostelState extends State<Hostel> {
  final PageController _pageController = PageController();
  int _currentSlide = 0;
  final int _totalSlides = 8;

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
          "Hostel & Campus Life",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: SizedBox(
                    height: 190,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _totalSlides,
                      onPageChanged: (index) {
                        setState(() {
                          _currentSlide = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(
                              Icons.image,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${_currentSlide + 1}/$_totalSlides",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Hostel Name Here",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Campus Facilities",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 25),
                    SizedBox(width: 4),
                    Text(
                      "4.5/5",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: const [
                FacilityItem(icon: Icons.bed, label: "AC Rooms"),
                FacilityItem(icon: Icons.wifi, label: "Free WiFi"),
                FacilityItem(icon: Icons.restaurant, label: "Mess"),
              ],
            ),

            const SizedBox(height: 16),
            Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 22),

            const HostelInfo(
              title: "Hostel Information",
              items: [
                InfoItem(
                  icon: Icons.apartment,
                  text: "Separate hostels for boys and girls",
                ),
                InfoItem(icon: Icons.group, text: "2-3 students per room"),
                InfoItem(icon: Icons.security, text: "24/7 security with CCTV"),
                InfoItem(icon: Icons.event_seat, text: "Total Rooms"),
              ],
            ),
            const SizedBox(height: 14),
            Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 22),

            const HostelInfo(
              title: "Campus Amenities",
              items: [
                InfoItem(icon: Icons.fitness_center, text: "Gym"),
                InfoItem(icon: Icons.sports_soccer, text: "Sports Complex"),
                InfoItem(icon: Icons.library_books, text: "Library"),
                InfoItem(icon: Icons.local_hospital, text: "Medical Center"),
              ],
            ),

            const SizedBox(height: 14),
            Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Student Reviews",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                //View all
              ],
            ),
            const SizedBox(height: 12),

            const ReviewItem(
              name: "Sarah Johnson",
              rating: 4,
              review:
                  "Great facilities and friendly environment. The rooms are spacious and well-maintained.",
            ),
            const ReviewItem(
              name: "Mike Chen",
              rating: 5,
              review:
                  "The campus life is vibrant with lots of activities. Hostel mess food is good too!",
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Book Hostel Tour",
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

class FacilityItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const FacilityItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: Colors.black87),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class HostelInfo extends StatelessWidget {
  final String title;
  final List<InfoItem> items;

  const HostelInfo({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 6,
                offset: const Offset(0, 5),
              ),
            ],

            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children:
                items
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(item.icon, size: 28),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                item.text,
                                style: const TextStyle(fontSize: 15.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class InfoItem {
  final IconData icon;
  final String text;

  const InfoItem({required this.icon, required this.text});
}

class ReviewItem extends StatelessWidget {
  final String name;
  final int rating;
  final String review;

  const ReviewItem({
    super.key,
    required this.name,
    required this.rating,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(radius: 30, child: Icon(Icons.person, size: 36)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(review, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
