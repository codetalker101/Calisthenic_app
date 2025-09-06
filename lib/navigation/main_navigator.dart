import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../pages/workouts/workouts.dart';
import '../pages/meals/meals.dart';
import '../pages/progress/progress.dart';
import '../pages/includes/_navbar.dart';

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
      bottomNavigationBar: Navbar(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Home Tab Navigator
          Navigator(
            key: _navKeys[0],
            onGenerateRoute: (route) => MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          ),
          // Workouts Tab Navigator
          Navigator(
            key: _navKeys[1],
            onGenerateRoute: (route) => MaterialPageRoute(
              builder: (context) => const WorkoutsPage(),
            ),
          ),
          // Meals Tab Navigator
          Navigator(
            key: _navKeys[2],
            onGenerateRoute: (route) => MaterialPageRoute(
              builder: (context) => const MealsPage(),
            ),
          ),
          // Progress Tab Navigator
          Navigator(
            key: _navKeys[3],
            onGenerateRoute: (route) => MaterialPageRoute(
              builder: (context) => ProgressPage(events: []), // FIXED
            ),
          ),
        ],
      ),
    );
  }
}
