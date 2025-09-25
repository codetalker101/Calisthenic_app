import 'package:flutter/material.dart';
import 'package:calisthenics_app/features/home/home.dart';
import 'package:calisthenics_app/features/workouts/presentation/workouts.dart';
import 'package:calisthenics_app/features/meals/presentation/meals.dart';
import 'package:calisthenics_app/features/progress/presentation/progress.dart';
import 'package:calisthenics_app/core/widgets/_navbar.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;
  final List<GlobalKey<NavigatorState>> _navKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onTabTapped(int index) {
    if (index == _currentIndex) {
      // If tapping the same tab, pop until root
      _navKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      // If switching to another tab, also reset that tab
      _navKeys[index].currentState?.popUntil((route) => route.isFirst);

      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF151515),
      extendBody: true, // body goes under navbar
      body: Stack(
        children: [
          /// Page content
          IndexedStack(
            index: _currentIndex,
            children: [
              Navigator(
                key: _navKeys[0],
                onGenerateRoute: (route) => MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              ),
              Navigator(
                key: _navKeys[1],
                onGenerateRoute: (route) => MaterialPageRoute(
                  builder: (context) => const WorkoutsPage(),
                ),
              ),
              Navigator(
                key: _navKeys[2],
                onGenerateRoute: (route) => MaterialPageRoute(
                  builder: (context) => const MealsPage(),
                ),
              ),
              Navigator(
                key: _navKeys[3],
                onGenerateRoute: (route) => MaterialPageRoute(
                  builder: (context) => ProgressPage(events: []),
                ),
              ),
            ],
          ),

          /// Floating Navbar
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 15), // distance from bottom
              child: Navbar(
                currentIndex: _currentIndex,
                onTabTapped: _onTabTapped,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
