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
          height: 0.3,
          color: Colors.grey,
        ),
        ClipRRect(
          borderRadius: BorderRadius.zero,
          child: Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFFFFFFFF),
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.black54,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              currentIndex: currentIndex,
              onTap: onTabTapped,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w400),
              enableFeedback: false,
              items: [
                _buildNavItem('Home', 'assets/icons/HomeIcon4.svg', 0),
                _buildNavItem('Workouts', 'assets/icons/Workout Icon.svg', 1),
                _buildNavItem('Planners', 'assets/icons/PlannerIcon2.svg', 2),
                _buildNavItem('Profile', 'assets/icons/ProfileIcon1.svg', 3),
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
          currentIndex == index ? Colors.green : Colors.black54,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }
}
