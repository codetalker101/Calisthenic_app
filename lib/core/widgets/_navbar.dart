import 'dart:ui'; // for ImageFilter
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Color(0xFF4A4A4A).withValues(alpha: 0.1),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15), // blur effect
          child: Container(
            color: Color(0xFFECE6EF).withValues(alpha: 0.7), // glass effect
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent, // transparent navbar
              elevation: 0,
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
                fontFamily: "SF-Pro-Display-Thin",
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: "SF-Pro-Display-Thin",
              ),
              enableFeedback: false,
              items: [
                _buildNavItem('Home', 'assets/icons/HomeIcon3.svg', 0),
                _buildNavItem('Workouts', 'assets/icons/Workout Icon.svg', 1),
                _buildNavItem('Meals', 'assets/icons/MealsIcon3.svg', 2),
                _buildNavItem('Progress', 'assets/icons/StatsIcon2.svg', 3),
              ],
            ),
          ),
        ),
      ),
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
