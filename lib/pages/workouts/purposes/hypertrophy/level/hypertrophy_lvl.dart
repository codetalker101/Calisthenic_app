import 'package:flutter/material.dart';

class HypertrophyLevelPage extends StatelessWidget {
  const HypertrophyLevelPage({super.key});

  static const List<Map<String, dynamic>> levels = [
    {
      'title': 'Beginner',
      'subtitle':
          'New to calisthenic? Start with foundational hypertrophy workouts',
      'icon': Icons.flag_outlined,
      'image': 'assets/images/workout1.jpg',
    },
    {
      'title': 'Easy',
      'subtitle': 'Gradual progression for building muscles',
      'icon': Icons.terrain,
      'image': 'assets/images/workout2.jpg',
    },
    {
      'title': 'Intermediate',
      'subtitle': 'Maximize your muscles grow',
      'icon': Icons.trending_up,
      'image': 'assets/images/workout3.jpg',
    },
    {
      'title': 'Advanced',
      'subtitle': 'Elite-level hypertrophy workouts challenges',
      'icon': Icons.bolt,
      'image': 'assets/images/workout4.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text(
          'Hypertrophy Training',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'AudioLinkMono',
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            children: [
              const SizedBox(height: 0),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: levels.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final level = levels[index];
                  return _buildLevelCard(level);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelCard(Map<String, dynamic> level) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(level['image']),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(15),
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Icon(
              level['icon'],
              color: Colors.green[200],
              size: 28,
            ),
          ),
          title: Text(
            level['title'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
              shadows: [
                Shadow(
                  blurRadius: 6,
                  color: Colors.black87,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              level['subtitle'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontFamily: 'OpenSans',
                shadows: [
                  Shadow(
                    blurRadius: 4,
                    color: Colors.black87,
                    offset: Offset(1, 1),
                  )
                ],
              ),
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.green[200],
            size: 22,
          ),
        ),
      ),
    );
  }
}
