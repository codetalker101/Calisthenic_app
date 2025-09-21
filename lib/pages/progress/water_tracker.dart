import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WaterTrackerPage extends StatefulWidget {
  const WaterTrackerPage({super.key});

  @override
  State<WaterTrackerPage> createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
  int waterIntake = 1200; // current intake ml
  final int goal = 2000; // ml per day

  // Example weekly data
  List<int> weeklyIntake = [1800, 1500, 2000, 1200, 1700, 2000, 1300];

  int selectedChart = 0; // 0 = ml, 1 = percentage

  void _addWater(int amount) {
    setState(() {
      waterIntake += amount;
      if (waterIntake > goal) waterIntake = goal;
    });
  }

  void _reset() {
    setState(() {
      waterIntake = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double percent = waterIntake / goal;

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
              'Water tracker',
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
            // 🔹 Chart Container
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

                  // Chart
                  SizedBox(
                    height: 260,
                    child: Echarts(
                      option: selectedChart == 0
                          ? '''
                        {
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
                            max: 2500,
                            interval: 500,
                            axisLine: { lineStyle: { color: '#999' } },
                            axisLabel: { formatter: '{value} ml', color: '#666' },
                            splitLine: { lineStyle: { color: '#eee' } }
                          },
                          series: [{
                            data: ${weeklyIntake.toString()},
                            type: 'bar',
                            barWidth: 30,
                            itemStyle: {
                              color: '#26AAC7',
                              borderRadius: [6,6,0,0]
                            },
                            label: { show: false }
                          }],
                          grid: {
                            left: '5%',
                            right: '5%',
                            bottom: '10%',
                            top: '5%',
                            containLabel: true
                          }
                        }
                      '''
                          : '''
                        {
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
                            max: 100,
                            interval: 20,
                            axisLine: { lineStyle: { color: '#999' } },
                            axisLabel: { formatter: '{value}%', color: '#666' },
                            splitLine: { lineStyle: { color: '#eee' } }
                          },
                          series: [{
                            data: ${weeklyIntake.map((ml) => ((ml / goal) * 100).toStringAsFixed(1)).toList()},
                            type: 'line',
                            symbol: 'circle',
                            symbolSize: 10,
                            itemStyle: { color: '#26AAC7' },
                            lineStyle: { color: '#26AAC7', width: 2 },
                            smooth: true
                          }],
                          grid: {
                            left: '5%',
                            right: '5%',
                            bottom: '15%',
                            top: '5%',
                            containLabel: true
                          }
                        }
                      ''',
                    ),
                  ),

                  const SizedBox(height: 5),

                  // 🔹 Toggle Button
                  Center(
                    child: SizedBox(
                      width: 280,
                      height: 30,
                      child: Material(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xFFECE6EF),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Stack(
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              transitionBuilder: (child, animation) =>
                                  FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                              child: Align(
                                key: ValueKey<int>(selectedChart),
                                alignment: selectedChart == 0
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: Container(
                                  width: 140,
                                  height: 30,
                                  color: const Color(0xFF26AAC7),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        setState(() => selectedChart = 0),
                                    child: Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/water_drop.svg",
                                            width: 14,
                                            height: 14,
                                            color: selectedChart == 0
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "Milliliters",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: selectedChart == 0
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              color: selectedChart == 0
                                                  ? Colors.white
                                                  : Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        setState(() => selectedChart = 1),
                                    child: Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/chart.svg",
                                            width: 14,
                                            height: 14,
                                            color: selectedChart == 1
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "Percentage",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: selectedChart == 1
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              color: selectedChart == 1
                                                  ? Colors.white
                                                  : Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 Water Statistics Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.local_drink,
                              color: Color(0xFF26AAC7), size: 30),
                          const SizedBox(height: 8),
                          Text(
                            "$waterIntake ml",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF26AAC7),
                            ),
                          ),
                          Text(
                            "Current Intake",
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
                          horizontal: 16, vertical: 25),
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
                            "$goal ml",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFD700),
                            ),
                          ),
                          Text(
                            "Daily Goal",
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

            const SizedBox(height: 20),

            // 🔹 Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF26AAC7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => _addWater(250),
                  child: const Text(
                    "+250 ml",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF26AAC7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => _addWater(500),
                  child: const Text(
                    "+500 ml",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            TextButton(
              onPressed: _reset,
              child: const Text(
                "Reset",
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
