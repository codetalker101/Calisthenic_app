import 'package:flutter/material.dart';

class LogsActivitiesPage extends StatelessWidget {
  const LogsActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFECE6EF),
        elevation: 0,
        scrolledUnderElevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              'Logs activities',
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Example for a single day
          _buildDailyLog(
            date: "Sept 1, 2025",
            workouts: [
              "Endurance Run - 30 min (200 kcal)",
              "Yoga - 20 min (100 kcal)"
            ],
            macros: {
              "Protein": "66/120 g",
              "Carbs": "200/300 g",
              "Fat": "40/70 g"
            },
            calories: "320 kcal burned",
            water: "2.5 L",
            sleep: "7h 45m",
            meals: {
              "Breakfast": "Oatmeal + Banana",
              "Lunch": "Chicken Salad",
              "Snack": "Protein Bar",
              "Dinner": "Grilled Salmon + Veggies",
            },
          ),
          _buildDailyLog(
            date: "Aug 31, 2025",
            workouts: ["Strength Training - 45 min (300 kcal)"],
            macros: {
              "Protein": "90/120 g",
              "Carbs": "180/300 g",
              "Fat": "50/70 g"
            },
            calories: "300 kcal burned",
            water: "2.0 L",
            sleep: "6h 30m",
            meals: {
              "Breakfast": "Smoothie",
              "Lunch": "Turkey Wrap",
              "Snack": "Nuts",
              "Dinner": "Steak + Rice",
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDailyLog({
    required String date,
    required List<String> workouts,
    required Map<String, String> macros,
    required String calories,
    required String water,
    required String sleep,
    required Map<String, String> meals,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.all(16),
        title: Text(
          date,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          _buildSection(
              "🏋️ Workouts",
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: workouts.map((w) => Text("• $w")).toList(),
              )),
          _buildSection(
              "🍗 Macros",
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: macros.entries
                    .map((e) => Text("${e.key}: ${e.value}"))
                    .toList(),
              )),
          _buildSection("🔥 Calories", Text(calories)),
          _buildSection("💧 Water", Text(water)),
          _buildSection("😴 Sleep", Text(sleep)),
          _buildSection(
              "🍽️ Meals",
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: meals.entries
                    .map((e) => Text("${e.key}: ${e.value}"))
                    .toList(),
              )),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black)),
          const SizedBox(height: 6),
          content,
        ],
      ),
    );
  }
}
