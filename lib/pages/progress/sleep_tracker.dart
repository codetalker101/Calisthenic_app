import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';

class SleepTrackerPage extends StatefulWidget {
  const SleepTrackerPage({super.key});

  @override
  State<SleepTrackerPage> createState() => _SleepTrackerPageState();
}

class _SleepTrackerPageState extends State<SleepTrackerPage> {
  double sleepGoal = 8; // hours
  double todaySleep = 6.5; // hours

  List<double> weeklySleep = [7, 6.5, 8, 5, 7.5, 6, 8]; // last 7 days

  @override
  Widget build(BuildContext context) {
    double percent = todaySleep / sleepGoal;
    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        title: const Text("Sleep Tracker"),
        centerTitle: true,
        backgroundColor: const Color(0xFF763EB0),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circular progress for today’s sleep
            CircularPercentIndicator(
              radius: 100,
              lineWidth: 14,
              percent: percent > 1 ? 1 : percent,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${todaySleep.toStringAsFixed(1)}h",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "of ${sleepGoal.toStringAsFixed(0)}h",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              progressColor: const Color(0xFF763EB0),
              backgroundColor: Colors.grey.shade400,
              circularStrokeCap: CircularStrokeCap.round,
            ),
            const SizedBox(height: 30),

            // Weekly chart
            const Text(
              "Last 7 Days",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ["M", "T", "W", "T", "F", "S", "S"];
                          return Text(
                            days[value.toInt() % days.length],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: weeklySleep.asMap().entries.map((entry) {
                    int index = entry.key;
                    double hours = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: hours,
                          color: const Color(0xFF763EB0),
                          borderRadius: BorderRadius.circular(6),
                          width: 18,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Button to add/edit sleep data
            ElevatedButton(
              onPressed: () {
                // TODO: Add functionality for adding/editing sleep
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Add/Edit Sleep Data tapped")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF763EB0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                "Add/Edit Sleep Data",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
