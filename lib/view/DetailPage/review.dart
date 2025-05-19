import 'package:college_app/model/review.dart';
import 'package:college_app/services/user_services.dart';
import 'package:college_app/view/SignUpLogin/FirstPage.dart';
import 'package:college_app/view_model/profile_controller.dart';
import 'package:college_app/view_model/themeController.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import '../../view_model/controller.dart';

class Reviews extends StatefulWidget {
  final String uid;

  const Reviews(this.uid, {super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  SharedPreferences? prefs;
  bool isUserLoggedIn = false;
  List<Review> _reviews = [];
  var pfp = Get.find<ProfileController>();
  var controller = Get.put(Controller());
  double averageRating = 0;
  List<int> percents = [0, 0, 0, 0, 0];

  @override
  void initState() {
    super.initState();
    _loadPrefs();
    getReviews();
  }

  Future<void> _loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isUserLoggedIn = prefs?.getString('auth_token') != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
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

      body: Obx(() {
        final theme = ThemeController.to.currentTheme;

        return SingleChildScrollView(
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
                      backgroundColor: theme.filterSelectedColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
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
              _buildRatingBar("5 star", percents[0]),
              const SizedBox(height: 8),
              _buildRatingBar("4 star", percents[1]),
              const SizedBox(height: 8),
              _buildRatingBar("3 star", percents[2]),
              const SizedBox(height: 8),
              _buildRatingBar("2 star", percents[3]),
              const SizedBox(height: 8),
              _buildRatingBar("1 star", percents[4]),
              const SizedBox(height: 24),
              const SizedBox(height: 16),
              Divider(color: Colors.grey, thickness: 0.5),
              const SizedBox(height: 22),

              // Dynamic review list
              ..._reviews.map((review) {
                return _buildReviewItem(
                  review.name,
                  review.studentemail,
                  review.reviewtext,
                  review.rating.toDouble(),
                  "date",
                  review.likes,
                  10,
                );
              }).toList(),
              // ElevatedButton.icon(
              //   onPressed: () {
              //     _showFilterPopup(context);
              //   },
              //   icon: const Icon(Icons.filter_list, size: 30),
              //   label: const Text(
              //     "Filter Reviews",
              //     style: TextStyle(fontSize: 19),
              //   ),
              //   style: ElevatedButton.styleFrom(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 9,
              //       vertical: 8,
              //     ),
              //     backgroundColor: theme.filterSelectedColor,
              //     foregroundColor: Colors.white,
              //     minimumSize: const Size.fromHeight(48),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.zero,
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      }),
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

  Widget _buildStarRating(double rating, {double iconSize = 20}) {
    final theme = ThemeController.to.currentTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (rating >= index + 1) {
          return Icon(Icons.star, color: theme.starColor, size: iconSize);
        } else if (rating > index) {
          return Icon(Icons.star_half, color: theme.starColor, size: iconSize);
        } else {
          return Icon(
            Icons.star_border,
            color: theme.starColor,
            size: iconSize,
          );
        }
      }),
    );
  }

  Widget _buildRatingBar(String label, int percent) {
    final theme = ThemeController.to.currentTheme;
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
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
                    color: theme.filterSelectedColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "$percent%",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
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
          CircleAvatar(radius: 30, child: Icon(Icons.person, size: 36)),
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
                  style: const TextStyle(
                    color: Color(0xFF42A5F5),
                    fontSize: 15,
                  ),
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
                    Text(
                      "$likes",
                      style: TextStyle(fontSize: 15, color: Color(0xFF42A5F5)),
                    ),
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
        final theme = ThemeController.to.currentTheme;
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
                          color: theme.starColor,
                          size: 35,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.isGuestIn.value) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please Login First"),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.black,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        } else {
                          if (reviewController.text.isNotEmpty &&
                              selectedRating > 0) {
                            Navigator.pop(context);
                            Review review = Review(
                              name: pfp.profile.value!.name!,
                              uid: widget.uid,
                              studentemail: pfp.profile.value!.email!,
                              rating: selectedRating,
                              reviewtext: reviewController.text.trim(),
                              likes: 0,
                            );
                            Review? rev = await StudentService().postReview(
                              review,
                            );

                            if (rev != null) {
                              _reviews.insert(0, rev);
                              setState(() {});
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.filterSelectedColor,
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

  getReviews() async {
    _reviews = await StudentService().getReviews(widget.uid);

    averageRating = getAvgRating();
    percents = getPercents();

    setState(() {});
  }

  double getAvgRating() {
    int reviews = _reviews.length;

    int sum = 0;

    for (Review review in _reviews) {
      sum += review.rating;
    }

    setState(() {});

    return (sum / reviews);
  }

  List<int> getPercents() {
    List<int> percents = [0, 0, 0, 0, 0];
    List<int> per = [0, 0, 0, 0, 0];

    for (int i = 0; i < _reviews.length; i++) {
      switch (_reviews[i].rating) {
        case 5:
          per[0] += 1;
          break;
        case 4:
          per[1] += 1;
          break;
        case 3:
          per[2] += 1;
          break;
        case 2:
          per[3] += 1;
          break;
        case 1:
          per[4] += 1;
      }
    }

    for (int i = 0; i < per.length; i++) {
      percents[i] = ((per[i] * 100) / _reviews.length).toInt();
    }

    return percents;
  }
}
