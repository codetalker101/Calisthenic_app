import 'package:flutter/material.dart';

class CaloriesBurnedPage extends StatelessWidget {
  const CaloriesBurnedPage({super.key});

  @override
  Widget build(BuildContext context) {
    double burnedCalories = 750;
    double targetCalories = 1200;
    double progress = burnedCalories / targetCalories;

    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        backgroundColor: Color(0xFFECE6EF),
        elevation: 0,
        scrolledUnderElevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              'Calories tracker',
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circular progress (daily target)
            SizedBox(
              height: 180,
              width: 180,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: Colors.grey[400],
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF9B2354)),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${burnedCalories.toInt()} kcal",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "of ${targetCalories.toInt()} kcal",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Progress bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Daily Progress",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Burned activities list
            Expanded(
              child: ListView(
                children: [
                  _buildActivityCard("Running", "30 min", 300),
                  _buildActivityCard("Cycling", "45 min", 250),
                  _buildActivityCard("Push-ups", "20 min", 200),
                ],
              ),
            ),
          ],
        ),
      ),

      // Add activity button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF9B2354),
        onPressed: () {
          // Navigate to Add Activity Page
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildActivityCard(String title, String duration, int calories) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.local_fire_department, color: Color(0xFF9B2354)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black)),
                Text(duration,
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 13)),
              ],
            ),
          ),
          Text(
            "$calories kcal",
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
