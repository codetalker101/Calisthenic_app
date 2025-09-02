import 'package:flutter/material.dart';
import 'workouts_detail.dart';

class WorkoutsListPage extends StatelessWidget {
  const WorkoutsListPage({super.key});

  static const List<Map<String, String>> workouts = [
    {
      'title': 'Full Body Training',
      'image': 'assets/images/workout1.jpg',
    },
    {
      'title': 'Upper Body Training',
      'image': 'assets/images/workout2.jpg',
    },
    {
      'title': 'Lower Body Training',
      'image': 'assets/images/workout3.jpg',
    },
    {
      'title': 'Push Training',
      'image': 'assets/images/workout4.jpg',
    },
    {
      'title': 'Pull Training',
      'image': 'assets/images/workout2.jpg',
    },
    {
      'title': 'Core Training',
      'image': 'assets/images/workout3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFECE6EF),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              'Workout List',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'AudioLinkMono',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(workouts.length, (index) {
            final workout = workouts[index];
            String title = workout['title']!;
            if (title.length > 35) {
              title = '${title.substring(0, 35)}...';
            }

            return GestureDetector(
              onTap: () {
                // Navigate to WorkoutDetailPage with selected workout data
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (_) => WorkoutDetailPage(
                      title: workout['title']!,
                      image: workout['image']!,
                    ),
                  ),
                );
              },
              child: Container(
                height: screenHeight * 0.14,
                width: screenWidth * 0.95,
                margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          workout['image']!,
                          width: screenWidth * 0.23,
                          height: screenHeight * 0.12,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                          vertical: screenHeight * 0.02,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              workout['title']!,
                              style: const TextStyle(
                                color: Color(0xFF9B2354),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              title,
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
          }),
        ),
      ),
    );
  }
}
