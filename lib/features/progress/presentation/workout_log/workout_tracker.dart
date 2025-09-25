import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class WorkoutTrackerPage extends StatefulWidget {
  const WorkoutTrackerPage({super.key});

  @override
  State<WorkoutTrackerPage> createState() => _WorkoutTrackerPageState();
}

class _WorkoutTrackerPageState extends State<WorkoutTrackerPage> {
  // Workout Data
  double weeklyGoal = 5; // hours per week goal
  double todayWorkout = 1.5; // hours today

  int selectedChart = 0; // 0 = weekly, 1 = monthly, 2 = yearly

  // Dummy data
  List<double> weeklyDuration = [1, 1.5, 0.75, 2, 1.25, 1, 2.5]; // 7 days
  List<double> monthlyDuration = [8, 12, 10, 15]; // 4 weeks
  List<double> yearlyDuration = [
    40,
    50,
    60,
    55,
    70,
    65,
    80,
    75,
    90,
    85,
    100,
    95
  ]; // 12 months

  // Dynamic chart max values
  double get maxWeekly => weeklyDuration.reduce((a, b) => a > b ? a : b) + 1;
  double get maxMonthly => monthlyDuration.reduce((a, b) => a > b ? a : b) + 5;
  double get maxYearly => yearlyDuration.reduce((a, b) => a > b ? a : b) + 20;

  /// AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 1,
      title: const Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Workout tracker',
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

  /// Chart Options
  String _weeklyChartOption() => '''
  {
    animationDuration: 500,   // default ~1000ms
    animationEasing: 'cubicOut', // smoother but quick ease
    xAxis: {
      type: 'category',
      data: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'],
      axisLabel: { color: '#666' }
    },
    yAxis: {
      type: 'value',
      min: 0,
      max: $maxWeekly,
      axisLabel: { formatter: '{value}h', color: '#666' },
      splitLine: { lineStyle: { color: '#eee' } }
    },
    series: [{
      data: ${weeklyDuration.toString()},
      type: 'bar',
      barWidth: 30,
      itemStyle: { color: '#FAA34D', borderRadius: [6,6,0,0] }
    }],
    grid: { left: '5%', right: '5%', bottom: '10%', top: '5%', containLabel: true }
  }
  ''';

  String _monthlyChartOption() => '''
  {
    animationDuration: 500,   // 🔹 make bars animate faster (default ~1000ms)
    animationEasing: 'cubicOut', // 🔹 smoother but quick ease
    xAxis: {
      type: 'category',
      data: ['Week 1','Week 2','Week 3','Week 4'],
      axisLabel: { color: '#666' }
    },
    yAxis: {
      type: 'value',
      min: 0,
      max: $maxMonthly,
      axisLabel: { formatter: '{value}h', color: '#666' },
      splitLine: { lineStyle: { color: '#eee' } }
    },
    series: [{
      data: ${monthlyDuration.toString()},
      type: 'bar',
      barWidth: 35,
      itemStyle: { color: '#FAA34D', borderRadius: [6,6,0,0] }
    }],
    grid: { left: '5%', right: '5%', bottom: '10%', top: '5%', containLabel: true }
  }
  ''';

  String _yearlyChartOption() => '''
  {
    animationDuration: 500,   // default ~1000ms
    animationEasing: 'cubicOut', // smoother but quick ease
    xAxis: {
      type: 'category',
      data: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
      axisLabel: { color: '#666' }
    },
    yAxis: {
      type: 'value',
      min: 0,
      max: $maxYearly,
      axisLabel: { formatter: '{value}h', color: '#666' },
      splitLine: { lineStyle: { color: '#eee' } }
    },
    series: [{
      data: ${yearlyDuration.toString()},
      type: 'line',
      symbol:'circle',
      symbolSize: '10',
      smooth: true,
      itemStyle: { color: '#FAA34D', borderRadius: [6,6,0,0] }
    }],
    grid: { left: '5%', right: '5%', bottom: '10%', top: '5%', containLabel: true }
  }
  ''';

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
          Text(
            selectedChart == 0
                ? "Last 7 Days"
                : selectedChart == 1
                    ? "Last 4 Weeks"
                    : "Yearly Recap",
            style: const TextStyle(
              fontSize: 12,
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
    return Echarts(
      option: selectedChart == 0
          ? _weeklyChartOption()
          : selectedChart == 1
              ? _monthlyChartOption()
              : _yearlyChartOption(),
    );
  }

  /// Toggle
  Widget _buildChartToggle() {
    return SizedBox(
      width: 300,
      height: 30,
      child: Material(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xFFECE6EF),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: Align(
                key: ValueKey<int>(selectedChart),
                alignment: selectedChart == 0
                    ? Alignment.centerLeft
                    : selectedChart == 1
                        ? Alignment.center
                        : Alignment.centerRight,
                child: Container(
                  width: 100,
                  height: 30,
                  color: const Color(0xFFFAA34D),
                ),
              ),
            ),
            Row(
              children: [
                _toggleButton("Weekly", 0),
                _toggleButton("Monthly", 1),
                _toggleButton("Yearly", 2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleButton(String label, int index) {
    final isSelected = selectedChart == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedChart = index),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  /// Stats Section
  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _statCard(Icons.fitness_center, const Color(0xFF763EB0),
                "${todayWorkout.toStringAsFixed(1)}h", "Duration"),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _statCard(Icons.timer, const Color(0xFFFFD700),
                "Goal: ${weeklyGoal.toStringAsFixed(0)}h", "Weekly Goal"),
          ),
        ],
      ),
    );
  }

  Widget _statCard(IconData icon, Color color, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            label,
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
