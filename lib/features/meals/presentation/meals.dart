import 'package:flutter/material.dart';
import 'package:calisthenics_app/features/meals/presentation/meals_details.dart';
import 'package:calisthenics_app/features/meals/presentation/meals_add.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  /// 🔹 Dummy meals data
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

  /// Get background image by meal type
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

  /// AppBar
  AppBar _buildAppBar() {
    return AppBar(
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
        IconButton(
          icon: const Icon(Icons.add, size: 35, color: Color(0xFF4A4A4A)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (_) => const MealAddPage()),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  /// Search + Filter Row
  Widget _buildSearchFilterRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
      child: Row(
        children: [
          // Filter button
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF9B2354),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon:
                  const Icon(Icons.filter_list, color: Colors.white, size: 22),
              onPressed: () {
                // TODO: filter action
              },
            ),
          ),

          const SizedBox(width: 10),

          // Search bar
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 12, right: 8),
                    child: Icon(Icons.search, color: Color(0xFF9B2354)),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 35,
                    minHeight: 35,
                  ),
                  hintText: "Search meals...",
                  hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Meal Card
  Widget _buildMealCard(Map<String, String> meal) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    String mealName = meal['name']!;
    if (mealName.length > 42) {
      mealName = '${mealName.substring(0, 42)}...';
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (_) => MealDetailPage(
              imageUrl: _getMealImage(meal['type']!),
              foodName: meal['name']!,
              description:
                  "A tasty ${meal['type']} option packed with protein.",
              calories: meal['calories']!,
              protein: meal['protein']!,
              time: "10 minutes",
              difficulty: "Medium",
              ingredients: [
                "200g chicken breast",
                "1 tbsp olive oil",
                "Salt & pepper",
                "Mixed vegetables",
              ],
              instructions: [
                "1. Season chicken with salt & pepper.",
                "2. Heat pan with olive oil.",
                "3. Cook chicken until golden brown.",
                "4. Add vegetables & stir fry.",
                "5. Serve warm.",
              ],
            ),
          ),
        );
      },
      child: Container(
        height: screenHeight * 0.13,
        width: screenWidth * 0.95,
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  _getMealImage(meal['type']!),
                  width: screenWidth * 0.22,
                  height: screenHeight * 0.22,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.013,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal['type']!,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              meal['calories']!,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 10),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${meal['protein']} protein',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 10),
                            ),
                          ],
                        ),
                        IconButton(
                          enableFeedback: false,
                          icon: const Icon(Icons.more_vert,
                              color: Color(0xFF9B2354), size: 20),
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
  }

  /// 🔹 Meals List
  Widget _buildMealsList() {
    return Column(
      children: List.generate(meals.length, (index) {
        return _buildMealCard(meals[index]);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchFilterRow(),
            const SizedBox(height: 15),
            _buildMealsList(),
          ],
        ),
      ),
    );
  }
}
