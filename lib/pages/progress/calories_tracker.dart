import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class CaloriesBurnedPage extends StatefulWidget {
  const CaloriesBurnedPage({super.key});

  @override
  State<CaloriesBurnedPage> createState() => _CaloriesBurnedPageState();
}

class _CaloriesBurnedPageState extends State<CaloriesBurnedPage> {
  double burnedCalories = 750;
  double targetCalories = 1200;

  // Example weekly calories burned
  List<double> weeklyCalories = [500, 750, 600, 800, 700, 900, 1000];

  int selectedChart = 0; // 0 = bar chart (calories), 1 = activity breakdown

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 Top container with chart
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 15, 16, 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Last 7 Days",
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: "SF-Pro-Display-Thin",
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 🔹 Chart
                  SizedBox(
                    height: 260,
                    child: Echarts(
                      option: '''
                        {
                          tooltip: {
                            trigger: 'item',
                            formatter: function(params) {
                              return params.name + ': ' + params.value + ' kcal';
                            }
                          },
                          xAxis: {
                            type: 'category',
                            data: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'],
                            axisTick: { show: false },
                            axisLine: { lineStyle: { color: '#999' } },
                            axisLabel: { color: '#666' }
                          },
                          yAxis: {
                            type: 'value',
                            min: 0,
                            max: 3000,
                            axisLine: { lineStyle: { color: '#999' } },
                            axisLabel: {
                              formatter: '{value}',
                              color: '#666'
                            },
                            splitLine: { lineStyle: { color: '#eee' } }
                          },
                          series: [{
                            data: ${weeklyCalories.toString()},
                            type: 'bar',
                            barWidth: 30,
                            itemStyle: {
                              color: '#9B2354',
                              borderRadius: [6, 6, 0, 0]
                            },
                            label: {
                              show: false   // 🔹 hide static labels
                            }
                          }],
                          grid: {
                            left: '5%',
                            right: '5%',
                            bottom: '10%',
                            top: '5%',
                            containLabel: true
                          }
                        }
                    ''',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 Burned vs Target Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 25,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.local_fire_department,
                              color: Color(0xFF9B2354), size: 30),
                          const SizedBox(height: 8),
                          Text(
                            "${burnedCalories.toInt()} kcal",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF9B2354),
                            ),
                          ),
                          Text(
                            "Burned",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "SF-Pro-Display-Thin",
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 25,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.flag,
                              color: Color(0xFFFFD700), size: 30),
                          const SizedBox(height: 8),
                          Text(
                            "${targetCalories.toInt()} kcal",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFD700),
                            ),
                          ),
                          Text(
                            "Target",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "SF-Pro-Display-Thin",
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
