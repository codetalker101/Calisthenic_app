import 'package:flutter/material.dart';

class MacroNutrientsPage extends StatelessWidget {
  const MacroNutrientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    // Dummy Data (replace with dynamic values later)
    const int protein = 90; // g
    const int proteinGoal = 120;

    const int carbs = 180; // g
    const int carbsGoal = 250;

    const int fats = 60; // g
    const int fatsGoal = 80;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFECE6EF),
        elevation: 0,
        scrolledUnderElevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              'Macro nutrients tracker',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'AudioLinkMono',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFECE6EF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Macro nutrients intake",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 5),
            // Macronutrients Breakdown
            _buildMacroCard(
              "Protein",
              protein,
              proteinGoal,
              Colors.blue,
              screenWidth,
            ),
            _buildMacroCard(
              "Carbohydrates",
              carbs,
              carbsGoal,
              Colors.orange,
              screenWidth,
            ),
            _buildMacroCard(
              "Fats",
              fats,
              fatsGoal,
              Colors.green,
              screenWidth,
            ),

            const SizedBox(height: 30),

            // Meals Breakdown Example
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Meals Breakdown",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildMealCard(
                "Breakfast", "450 kcal", "20g protein, 60g carbs, 10g fat"),
            _buildMealCard(
                "Lunch", "650 kcal", "30g protein, 80g carbs, 20g fat"),
            _buildMealCard(
                "Dinner", "350 kcal", "25g protein, 40g carbs, 15g fat"),
            _buildMealCard("Snacks", "0 kcal", "—"),
          ],
        ),
      ),
    );
  }

  // Reusable Macro Card
  Widget _buildMacroCard(
    String name,
    int value,
    int goal,
    Color color,
    double screenWidth,
  ) {
    final percent = value / goal;
    return Container(
      width: screenWidth * 0.9,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: percent > 1 ? 1 : percent,
            minHeight: 8,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 6),
          Text(
            "$value g / $goal g",
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  // Reusable Meal Card
  Widget _buildMealCard(String title, String kcal, String details) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.restaurant_menu, color: Color(0xFF9B2354)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          Text(
            kcal,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          )
        ],
      ),
    );
  }
}
