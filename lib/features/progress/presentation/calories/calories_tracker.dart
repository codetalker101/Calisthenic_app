import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class CaloriesBurnedPage extends StatefulWidget {
  const CaloriesBurnedPage({super.key});

  @override
  State<CaloriesBurnedPage> createState() => _CaloriesBurnedPageState();
}

class _CaloriesBurnedPageState extends State<CaloriesBurnedPage> {
  // Calories Data
  double burnedCalories = 450;
  double targetCalories = 2500;

  final List<double> weeklyCaloriesBurned = [
    500,
    750,
    600,
    800,
    700,
    900,
    1000
  ];
  final List<double> weeklyCaloriesConsumed = [
    1800,
    2000,
    1750,
    2200,
    1900,
    2100,
    1950
  ];

  int selectedChart = 0; // 0 = burned, 1 = consumed

  // 🔹 Echarts Option
  String _buildChartOption() {
    final data =
        selectedChart == 0 ? weeklyCaloriesBurned : weeklyCaloriesConsumed;
    final color = selectedChart == 0 ? "#9B2354" : "#738F64";

    return '''
    {
      animationDuration: 500,   // default ~1000ms
      animationEasing: 'cubicOut', // smoother but quick ease
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
        axisLabel: { formatter: '{value}', color: '#666' },
        splitLine: { lineStyle: { color: '#eee' } }
      },
      series: [{
        data: ${data.toString()},
        type: 'bar',
        barWidth: 30,
        itemStyle: {
          color: '$color',
          borderRadius: [6, 6, 0, 0]
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
    ''';
  }

  /// AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 1,
      title: const Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Calories tracker',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'AudioLinkMono',
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  /// Chart Section
  Widget _buildChartSection() {
    return Container(
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
          SizedBox(height: 260, child: _buildChart()),
          const Divider(height: 1, thickness: 0.8),
          const SizedBox(height: 18),
          _buildChartToggle(),
        ],
      ),
    );
  }

  Widget _buildChart() {
    return Echarts(option: _buildChartOption());
  }

  /// Toggle
  Widget _buildChartToggle() {
    return SizedBox(
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
                  FadeTransition(opacity: animation, child: child),
              child: Align(
                key: ValueKey<int>(selectedChart),
                alignment: selectedChart == 0
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Container(
                  width: 140,
                  height: 30,
                  color: selectedChart == 0
                      ? const Color(0xFF9B2354)
                      : const Color(0xFF738F64),
                ),
              ),
            ),
            Row(
              children: [
                _toggleButton("Burned", Icons.local_fire_department, 0),
                _toggleButton("Consumed", Icons.restaurant, 1),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleButton(String label, IconData icon, int index) {
    final isSelected = selectedChart == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedChart = index),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : Colors.black87,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Statistics Section
  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _statCard(
              title: "Exercises",
              value: "${burnedCalories.toInt()} kcal",
              subtitle: "Burned",
              icon: Icons.local_fire_department,
              color: const Color(0xFF9B2354),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _statCard(
              title: "Consumed",
              value: "2000 kcal",
              subtitle: "Target: ${targetCalories.toInt()} kcal",
              icon: Icons.restaurant,
              color: const Color(0xFF738F64),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: "SF-Pro-Display-Thin",
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              fontFamily: "SF-Pro-Display-Thin",
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
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
            _buildChartSection(),
            const SizedBox(height: 10),
            _buildStatsSection(),
          ],
        ),
      ),
    );
  }
}
