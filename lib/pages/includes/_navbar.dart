import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Navbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const Navbar({
    super.key,
    required this.currentIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: const Color(0xFFECE6EF),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFFFFFFFF),
              selectedItemColor: const Color(0xFF9B2354),
              unselectedItemColor: Colors.black87,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              currentIndex: currentIndex,
              onTap: onTabTapped,
              selectedFontSize: 11,
              unselectedFontSize: 11,
              selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "SF-Pro-Display-Thin"),
              unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: "SF-Pro-Display-Thin"),
              enableFeedback: false, // enables haptic & splash feedback
              items: [
                _buildNavItem('Home', 'assets/icons/HomeIcon3.svg', 0),
                _buildNavItem('Workouts', 'assets/icons/Workout Icon.svg', 1),
                _buildNavItem('Meals', 'assets/icons/MealsIcon3.svg', 2),
                _buildNavItem('Progress', 'assets/icons/StatsIcon2.svg', 3),
              ],
            ),
          ),
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(
      String label, String assetPath, int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        assetPath,
        height: 24,
        width: 24,
        colorFilter: ColorFilter.mode(
          currentIndex == index ? const Color(0xFF9B2354) : Colors.black54,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }
}
