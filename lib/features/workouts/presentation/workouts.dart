import 'package:flutter/material.dart';
import 'package:calisthenics_app/features/workouts/presentation/workouts_list.dart';
import 'package:calisthenics_app/features/workouts/presentation/workouts_detail.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  /// Workout Data
  List<Map<String, dynamic>> get workoutTypes => [
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
          'subtitle': 'Max Strength Building',
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

  /// AppBar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }

  /// Section Title
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: 'SF-Pro-Display-Thin',
          color: Colors.black,
        ),
      ),
    );
  }

  /// Warmup & Stretching Vertical Cards
  Widget _buildVerticalCards(
      BuildContext context, double screenHeight, double screenWidth) {
    return Column(
      children: workoutTypes.take(2).map((workout) {
        return GestureDetector(
          onTap: () {
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
            margin: const EdgeInsets.only(bottom: 12),
            height: screenHeight * 0.13,
            width: screenWidth * 0.95,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
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
                            child: const Icon(Icons.image_not_supported,
                                color: Colors.grey),
                          ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workout['title'] ?? '',
                          style: const TextStyle(
                            color: Color(0xFF9B2354),
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
    );
  }

  /// Workouts Grid (Programs)
  Widget _buildWorkoutsGrid(BuildContext context) {
    return GridView.builder(
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
                    content:
                        Text('${workout['title']} page is not ready yet.')),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: workout['color'].withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child:
                      Icon(workout['icon'], color: workout['color'], size: 35),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Exercises"),
              const SizedBox(height: 5),
              _buildVerticalCards(context, screenHeight, screenWidth),
              const Divider(thickness: 1, color: Colors.black26, height: 30),
              _sectionTitle("Workouts programs"),
              const SizedBox(height: 8),
              _buildWorkoutsGrid(context),
            ],
          ),
        ),
      ),
    );
  }
}
