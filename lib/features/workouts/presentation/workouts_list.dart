import 'package:flutter/material.dart';
import 'package:calisthenics_app/features/workouts/presentation/workouts_detail.dart';

class WorkoutsListPage extends StatelessWidget {
  const WorkoutsListPage({super.key});

  static const List<Map<String, String>> workouts = [
    {'title': 'Full Body Training', 'image': 'assets/images/workout1.jpg'},
    {'title': 'Upper Body Training', 'image': 'assets/images/workout2.jpg'},
    {'title': 'Lower Body Training', 'image': 'assets/images/workout3.jpg'},
    {'title': 'Push Training', 'image': 'assets/images/workout4.jpg'},
    {'title': 'Pull Training', 'image': 'assets/images/workout2.jpg'},
  ];

  /// AppBar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFECE6EF),
      elevation: 0,
      scrolledUnderElevation: 1,
      leading: IconButton(
        enableFeedback: false,
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Workout list',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'AudioLinkMono',
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  /// Workout Card
  Widget _buildWorkoutCard(
    BuildContext context,
    String title,
    String image,
    double screenWidth,
    double screenHeight,
  ) {
    // trim long titles
    String trimmedTitle =
        title.length > 35 ? '${title.substring(0, 35)}...' : title;

    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (_) => WorkoutDetailPage(title: title, image: image),
          ),
        );
      },
      child: Container(
        height: screenHeight * 0.13,
        width: screenWidth * 0.95,
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            // Thumbnail
            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  image,
                  width: screenWidth * 0.23,
                  height: screenHeight * 0.12,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Title section
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
                    // Title (red bold)
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF9B2354),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),

                    // Trimmed Title (black)
                    Text(
                      trimmedTitle,
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
  }

  /// Workout List
  Widget _buildWorkoutList(
      BuildContext context, double screenWidth, double screenHeight) {
    return Column(
      children: workouts.map((workout) {
        return _buildWorkoutCard(
          context,
          workout['title']!,
          workout['image']!,
          screenWidth,
          screenHeight,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: _buildWorkoutList(context, screenWidth, screenHeight),
      ),
    );
  }
}
