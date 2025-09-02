import 'package:flutter/material.dart';
import 'workouts_list.dart';
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
        'subtitle': 'Prepare your body for training',
        'color': Colors.blue,
        'icon': Icons.accessibility_new,
        'route': null,
      },
      {
        'title': 'Stretching',
        'subtitle': 'Improve flexibility & recovery',
        'color': Colors.purple,
        'icon': Icons.self_improvement,
        'route': null,
      },
      {
        'title': 'Endurance',
        'subtitle': 'Muscle Stamina Training',
        'color': Colors.green,
        'icon': Icons.directions_run,
        'route': const WorkoutsListPage(),
      },
      {
        'title': 'Hypertrophy',
        'subtitle': 'Muscle Growth Program',
        'color': Colors.orange,
        'icon': Icons.fitness_center,
        'route': const WorkoutsListPage(),
      },
      {
        'title': 'Strength',
        'subtitle': 'Max Power Building',
        'color': Colors.red,
        'icon': Icons.bolt,
        'route': const WorkoutsListPage(),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        title: const Text(
          'Workouts Programs',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'AudioLinkMono',
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFECE6EF),
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
        child: GridView.builder(
          itemCount: workoutTypes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 cards per row
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1, // square
          ),
          itemBuilder: (context, index) {
            final workout = workoutTypes[index];
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
                          Text('${workout['title']} page is not ready yet.'),
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
      ),
    );
  }
}
