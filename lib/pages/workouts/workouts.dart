import 'package:flutter/material.dart';
import '../includes/_sidebar.dart';
import 'purposes/endurance/level/endurance_lvl.dart';
import 'purposes/hypertrophy/level/hypertrophy_lvl.dart';
import 'purposes/strength/level/strength_lvl.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  void openRightSidebar(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const RightSidebar();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0), // Slide from the right
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> workoutTypes = [
      {
        'title': 'Endurance',
        'subtitle': 'Muscle Stamina Training',
        'color': Colors.green,
        'icon': Icons.directions_run,
        'route': const EnduranceLevelPage(), // Add route reference
      },
      {
        'title': 'Hypertrophy',
        'subtitle': 'Muscle Growth Program',
        'color': Colors.orange,
        'icon': Icons.fitness_center,
        'route': const HypertrophyLevelPage(), // Add route reference
      },
      {
        'title': 'Strength',
        'subtitle': 'Max Power Building',
        'color': Colors.red,
        'icon': Icons.bolt,
        'route': const StrengthLevelPage(), // Add route reference
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
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
        backgroundColor: const Color(0xFFFFFFFF),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => openRightSidebar(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          children: [
            const SizedBox(height: 0),
            Expanded(
              child: ListView.separated(
                itemCount: workoutTypes.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  final workout = workoutTypes[index];
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        if (workout['title'] == 'Endurance') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EnduranceLevelPage(),
                            ),
                          );
                        } else if (workout['title'] == 'Hypertrophy') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const HypertrophyLevelPage(),
                            ),
                          );
                        } else if (workout['title'] == 'Strength') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StrengthLevelPage(),
                            ),
                          );
                        }
                      },
                      child: Card(
                        color: const Color(0xFFF8F8F8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: workout['color'].withOpacity(0.2),
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
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      workout['subtitle'],
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 13,
                                        fontFamily: 'OpenSans',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
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
