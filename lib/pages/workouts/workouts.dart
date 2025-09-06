import 'package:flutter/material.dart';
import 'workouts_list.dart';
import 'workouts_detail.dart';
import '../../pages/profile/profile.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final List<Map<String, dynamic>> workoutTypes = [
      {
        'title': 'Warming Up',
        'image': 'assets/images/workout1.jpg',
        'subtitle': 'Recovery workout and pre workout',
        'route': null,
      },
      {
        'title': 'Stretching',
        'image': 'assets/images/workout1.jpg',
        'subtitle': 'Improve flexibility or Cooling down',
        'route': null,
      },
      {
        'title': 'Endurance Training',
        'subtitle': 'Muscle Stamina Training',
        'color': Colors.green,
        'icon': Icons.directions_run,
        'route': const WorkoutsListPage(),
      },
      {
        'title': 'Hypertrophy Training',
        'subtitle': 'Muscle Growth Program',
        'color': Colors.yellow,
        'icon': Icons.fitness_center,
        'route': const WorkoutsListPage(),
      },
      {
        'title': 'Strength Training',
        'subtitle': 'Max Power Building',
        'color': Colors.orange,
        'icon': Icons.bolt,
        'route': const WorkoutsListPage(),
      },
      {
        'title': 'Power Training',
        'subtitle': 'Combine strength and speed',
        'color': Colors.red,
        'icon': Icons.sports_kabaddi,
        'route': const WorkoutsListPage(),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFECE6EF),
        scrolledUnderElevation: 1,
        title: const Text(
          'Workouts',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'AudioLinkMono',
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 9.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const ProfilePage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: ClipOval(
                child: Image.asset(
                  'assets/icons/saitama-profile-pic.png',
                  width: screenWidth * 0.13,
                  height: screenHeight * 0.13,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title above Vertical Rectangle Cards
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0, left: 4.0),
                child: Text(
                  "Exercises",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SF-Pro-Display-Thin',
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 5),
              // Vertical Rectangle Cards (Warmup & Stretching)
              Column(
                children: workoutTypes.take(2).map((workout) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => WorkoutDetailPage(
                            title: workout['title'],
                            image:
                                workout['image'], // safe: always has image now
                          ),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      height: 120, // keep fixed height
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Left side image with padding
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: (workout['image'] != null &&
                                      workout['image'].isNotEmpty)
                                  ? Image.asset(
                                      workout['image'],
                                      width: 100,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: 120,
                                      height: double.infinity,
                                      color: Colors.grey[200],
                                      child: const Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey),
                                    ),
                            ),
                          ),

                          // Right side text
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    workout['title'] ?? '',
                                    style: const TextStyle(
                                      color: Color(0xFF9B2354), // match style
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    workout['subtitle'] ?? '',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Separator Line
              const Divider(
                thickness: 1,
                color: Colors.black26,
                height: 30,
              ),

              // Title above Grid
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0, left: 4.0),
                child: Text(
                  "Workouts programs",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SF-Pro-Display-Thin',
                    color: Colors.black,
                  ),
                ),
              ),

              // Grid Cards (Endurance, Hypertrophy, Strength + Agility)
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: workoutTypes.length - 2,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final workout = workoutTypes[index + 2];
                  return GestureDetector(
                    onTap: () {
                      if (workout['route'] != null) {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => workout['route'],
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '${workout['title']} page is not ready yet.'),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: workout['color'].withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              workout['icon'],
                              color: workout['color'],
                              size: 35,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            workout['title'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SF-Pro-Display-Thin',
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            workout['subtitle'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: 'SF-Pro-Display-Thin',
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
