import 'package:flutter/material.dart';
import 'purposes/endurance/level/endurance_lvl.dart';
import 'purposes/hypertrophy/level/hypertrophy_lvl.dart';
import 'purposes/strength/level/strength_lvl.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import '../../pages/Profile/profile.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> workoutTypes = [
      {
        'title': 'Warming Up',
        'subtitle': 'Prepare your body for training',
        'color': Colors.blue,
        'icon': Icons.accessibility_new,
        'route': null, // You can add a dedicated page later
      },
      {
        'title': 'Stretching',
        'subtitle': 'Improve flexibility & recovery',
        'color': Colors.purple,
        'icon': Icons.self_improvement,
        'route': null, // You can add a dedicated page later
      },
      {
        'title': 'Endurance',
        'subtitle': 'Muscle Stamina Training',
        'color': Colors.green,
        'icon': Icons.directions_run,
        'route': const EnduranceLevelPage(),
      },
      {
        'title': 'Hypertrophy',
        'subtitle': 'Muscle Growth Program',
        'color': Colors.orange,
        'icon': Icons.fitness_center,
        'route': const HypertrophyLevelPage(),
      },
      {
        'title': 'Strength',
        'subtitle': 'Max Power Building',
        'color': Colors.red,
        'icon': Icons.bolt,
        'route': const StrengthLevelPage(),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        title: const Text(
          'Workout Programs',
          style: TextStyle(
            fontSize: 18,
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
              child: Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  'assets/icons/saitama-profile-pic.png',
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(11.0, 11, 11, 11),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: workoutTypes.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final workout = workoutTypes[index];
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        if (workout['route'] != null) {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      workout['route'],
                              transitionDuration:
                                  Duration.zero, // no transition
                              reverseTransitionDuration:
                                  Duration.zero, // no back transition
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
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              spreadRadius: 0,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
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
                              const SizedBox(width: 28),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      workout['title'],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SF-Pro-Display-Thin',
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      workout['subtitle'],
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12,
                                        fontFamily: 'SF-Pro-Display-Thin',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black54,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
