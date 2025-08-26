import 'package:flutter/material.dart';

class EnduranceLevelPage extends StatelessWidget {
  const EnduranceLevelPage({super.key});

  static const List<Map<String, dynamic>> levels = [
    {
      'title': 'Beginner',
      'subtitle': 'New to calisthenic? Start here!',
      'icon': Icons.flag_outlined,
      'image': 'assets/images/workout1.jpg',
    },
    {
      'title': 'Easy',
      'subtitle': 'Gradual progression for building stamina',
      'icon': Icons.terrain,
      'image': 'assets/images/workout2.jpg',
    },
    {
      'title': 'Intermediate',
      'subtitle': 'Challenge your endurance limits',
      'icon': Icons.trending_up,
      'image': 'assets/images/workout3.jpg',
    },
    {
      'title': 'Advanced',
      'subtitle': 'Elite-level endurance challenges',
      'icon': Icons.bolt,
      'image': 'assets/images/workout4.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: const Text(
            'Endurance Training',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'AudioLinkMono',
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: const Color(0xFFECE6EF),
        iconTheme: const IconThemeData(
          color: Colors.black, // back button color
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Column(
              children: List.generate(levels.length, (index) {
                final level = levels[index];

                // Level card
                return Material(
                  elevation: 0,
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    height: 100,
                    width: 290,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Left side → level image
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Material(
                            borderRadius: BorderRadius.circular(25),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.asset(
                              level['image'],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Right side → level details
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              double topPadding = constraints.maxHeight * 0.23;
                              double leftPadding = constraints.maxWidth * 0.04;
                              double rightPadding = constraints.maxWidth * 0.04;

                              return Padding(
                                padding: EdgeInsets.fromLTRB(
                                  leftPadding,
                                  topPadding,
                                  rightPadding,
                                  0,
                                ),
                                child: SizedBox(
                                  height: constraints.maxHeight - topPadding,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        level['title'],
                                        style: const TextStyle(
                                          color: Color(0xFF9B2354),
                                          fontSize: 13,
                                          fontFamily: "SF-Pro-Display-Thin",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          level['subtitle'],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontFamily: "SF-Pro-Display-Thin",
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
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
              }),
            ),
          ],
        ),
      ),
    );
  }
}
