import 'package:calisthenics_app/pages/meals/meals_details.dart';
import 'package:calisthenics_app/pages/meals/meals_add.dart';
import 'package:flutter/material.dart';
import '../../pages/profile/profile.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  // meals card background by its type
  String _getMealImage(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return 'assets/images/breakfast.jpg';
      case 'lunch':
        return 'assets/images/lunch.jpg';
      case 'snack':
        return 'assets/images/snacks.jpg';
      case 'dinner':
        return 'assets/images/dinner.jpg';
      default:
        return 'assets/images/default-meal.jpg';
    }
  }

  final List<Map<String, String>> meals = [
    {
      'type': 'Breakfast',
      'name': 'Banana Toast with whey protein, and melted cheese',
      'calories': '450 kcal',
      'protein': '55g',
    },
    {
      'type': 'Lunch',
      'name': 'Grilled Chicken',
      'calories': '600 kcal',
      'protein': '55g',
    },
    {
      'type': 'Snack',
      'name': 'L-men Protein Bar',
      'calories': '250 kcal',
      'protein': '55g',
    },
    {
      'type': 'Dinner',
      'name': 'Salmon Bowl',
      'calories': '550 kcal',
      'protein': '55g',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        title: const Text(
          'Meals',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'AudioLinkMono',
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFECE6EF),
        elevation: 0,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Search + Filter Row ---
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
              child: Row(
                children: [
                  // Search bar
                  Expanded(
                    child: Container(
                      height: 40,
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
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 12, right: 8),
                            child: Icon(Icons.search, color: Color(0xFF9B2354)),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 35,
                            minHeight: 35,
                          ),
                          hintText: "Search meals...",
                          hintStyle:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Filter button
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF9B2354),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.filter_list,
                        color: Colors.white,
                        size: 22,
                      ),
                      onPressed: () {
                        // TODO: filter action
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // --- Meals Cards ---
            Column(
              children: List.generate(meals.length, (index) {
                String mealName = meals[index]['name']!;
                if (mealName.length > 42) {
                  mealName = '${mealName.substring(0, 42)}...';
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (_) => const MealDetailPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: screenWidth * 0.28,
                    width: screenWidth * 0.95,
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
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              _getMealImage(meals[index]['type']!),
                              width: screenWidth * 0.22,
                              height: screenWidth * 0.22,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.02,
                              vertical: screenWidth * 0.03,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  meals[index]['type']!,
                                  style: const TextStyle(
                                    color: Color(0xFF9B2354),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    mealName,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          meals[index]['calories']!,
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 10),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          '${meals[index]['protein']} protein',
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      enableFeedback: false,
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Color(0xFF9B2354),
                                        size: 20,
                                      ),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
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

      // Floating Add (+) button
      floatingActionButton: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF9B2354),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (_) => const MealAddPage()),
            );
          },
          child: SizedBox(
            width: screenWidth * 0.155,
            height: screenWidth * 0.155,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
