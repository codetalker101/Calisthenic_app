import 'package:flutter/material.dart';

class WeightPage extends StatelessWidget {
  // Dummy data
  final double currentWeight = 72.5; // kg
  final double goalWeight = 68.0; // kg
  final double height = 1.75; // meters

  WeightPage({super.key});

  double calculateBMI() {
    return currentWeight / (height * height);
  }

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI();
    double weightChange = currentWeight - goalWeight;
    bool isLosing = currentWeight > goalWeight;

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
              'Weight tracker',
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Current Weight
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Current Weight",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      "${currentWeight.toStringAsFixed(1)} kg",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Goal Weight & Progress
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Goal Weight",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      "${goalWeight.toStringAsFixed(1)} kg",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: (goalWeight / currentWeight).clamp(0.0, 1.0),
                      color: const Color(0xFF9B2354),
                      backgroundColor: Colors.grey[300],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isLosing
                          ? "Need to lose ${weightChange.toStringAsFixed(1)} kg"
                          : "Need to gain ${weightChange.abs().toStringAsFixed(1)} kg",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // BMI
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "BMI (Body Mass Index)",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      bmi.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      bmi < 18.5
                          ? "Underweight"
                          : bmi < 25
                              ? "Normal"
                              : bmi < 30
                                  ? "Overweight"
                                  : "Obese",
                      style: TextStyle(
                        fontSize: 14,
                        color: bmi < 18.5
                            ? Colors.blue
                            : bmi < 25
                                ? Colors.green
                                : bmi < 30
                                    ? Colors.orange
                                    : Colors.red,
                      ),
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
}
