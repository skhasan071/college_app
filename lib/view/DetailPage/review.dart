import 'package:college_app/view/FirstPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class Reviews extends StatefulWidget {
  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  SharedPreferences? prefs;
  bool isUserLoggedIn = false;
  final List<Map<String, dynamic>> _reviews = [
    {
      "name": "Sarah Johnson",
      "role": "Computer Science Student",
      "review":
          "Great faculty and amazing campus life! The computer science program is challenging but rewarding. Professors are always willing to help.",
      "rating": 5.0,
      "date": "Jan 15, 2025",
      "likes": 45,
      "comments": 12,
    },
    {
      "name": "Michael Chen",
      "role": "Engineering Graduate",
      "review":
          "The engineering labs are well-equipped and modern. Career services could be better, but overall a solid educational experience.",
      "rating": 4.0,
      "date": "Jan 10, 2025",
      "likes": 32,
      "comments": 8,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isUserLoggedIn = prefs?.getString('authToken') != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    double averageRating = 3.0;
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text(
          "Reviews & Ratings",
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildStarRating(averageRating),

                    const SizedBox(height: 4),
                    const Text(
                      "Based on 2,456 reviews",
                      style: TextStyle(color: Colors.black, fontSize: 1),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (isUserLoggedIn) {
                      _showReviewDialog(context);
                    } else {
                      _showLoginPrompt(context);
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // No rounded border
                    ),
                  ),
                  child: const Text(
                    "Write a Review",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 22),

            // Rating distribution
            _buildRatingBar("5 star", 75),
            const SizedBox(height: 8),
            _buildRatingBar("4 star", 15),
            const SizedBox(height: 8),
            _buildRatingBar("3 star", 5),
            const SizedBox(height: 8),
            _buildRatingBar("2 star", 3),
            const SizedBox(height: 8),
            _buildRatingBar("1 star", 2),
            const SizedBox(height: 24),
            const SizedBox(height: 16),
            Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 22),

            // Dynamic review list
            ..._reviews.map((review) {
              return _buildReviewItem(
                review["name"],
                review["role"],
                review["review"],
                review["rating"],
                review["date"],
                review["likes"],
                review["comments"],
              );
            }).toList(),
            ElevatedButton.icon(
              onPressed: () {
                _showFilterPopup(context);
              },
              icon: const Icon(Icons.filter_list, size: 30),
              label: const Text(
                "Filter Reviews",
                style: TextStyle(fontSize: 19),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                backgroundColor: Colors.grey.shade900,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLoginPrompt(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Login Required",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Please log in to write a review.",
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // close dialog
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Firstpage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          "Log In",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _showFilterPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Filter Reviews",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _buildFilterOption("Positive Reviews", Colors.green, () {
                  Navigator.pop(context);
                  // Apply filter: 4-5 stars
                }),
                const SizedBox(height: 16),
                _buildFilterOption("Neutral Reviews", Colors.amber, () {
                  Navigator.pop(context);
                  // Apply filter: 3 stars
                }),
                const SizedBox(height: 16),
                _buildFilterOption("Negative Reviews", Colors.red, () {
                  Navigator.pop(context);
                  // Apply filter: 1-2 stars
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 14,
              height: 14,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildStarRating(double rating, {double iconSize = 20}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (rating >= index + 1) {
          return Icon(Icons.star, color: Colors.black, size: iconSize);
        } else if (rating > index) {
          return Icon(Icons.star_half, color: Colors.black, size: iconSize);
        } else {
          return Icon(Icons.star_border, color: Colors.black, size: iconSize);
        }
      }),
    );
  }

  Widget _buildRatingBar(String label, int percent) {
    return Row(
      children: [
        Text(label),
        const SizedBox(width: 6),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percent / 100,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text("$percent%"),
      ],
    );
  }

  Widget _buildReviewItem(
    String name,
    String role,
    String review,
    double rating,
    String date,
    int likes,
    int comments,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(Icons.person, color: Colors.black, size: 36),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    _buildStarRating(rating, iconSize: 18),
                  ],
                ),
                Text(
                  role,
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
                const SizedBox(height: 8),
                Text(
                  review,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  "Posted on $date",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.thumb_up_alt_outlined,
                      size: 25,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text("$likes", style: TextStyle(fontSize: 15)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showReviewDialog(BuildContext context) {
    final TextEditingController reviewController = TextEditingController();
    int selectedRating = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Write a Review",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: reviewController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: "Write your thoughts here...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          setModalState(() {
                            selectedRating = index + 1;
                          });
                        },
                        icon: Icon(
                          index < selectedRating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.black,
                          size: 35,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (reviewController.text.isNotEmpty &&
                            selectedRating > 0) {
                          Navigator.pop(context);
                          setState(() {
                            _reviews.insert(0, {
                              "name": "You",
                              "role": "Student",
                              "review": reviewController.text,
                              "rating": selectedRating.toDouble(),
                              "date": "Apr 15, 2025",
                              "likes": 0,
                              "liked": false,
                              "comments": 0,
                            });
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text("Submit"),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
