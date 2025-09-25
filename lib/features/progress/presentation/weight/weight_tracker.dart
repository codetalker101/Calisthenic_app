import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({super.key});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  // Dummy weight data
  List<double> weeklyWeight = [58, 58.5, 58, 59, 59.5, 60, 59.5];
  List<double> monthlyWeight = [58, 60, 62, 65];
  List<double> yearlyWeight = [
    58,
    58,
    60,
    60.5,
    60,
    61,
    62,
    59,
    60.5,
    62,
    63.5,
    65
  ];

  final double currentWeight = 72.5; // kg
  final double goalWeight = 68.0; // kg
  final double height = 1.75; // meters

  int selectedChart = 0; // 0 = weekly, 1 = monthly, 2 = yearly

  double calculateBMI() => currentWeight / (height * height);

  // Dynamic chart max values
  double get maxWeekly => weeklyWeight.reduce((a, b) => a > b ? a : b) + 5;
  double get maxMonthly => monthlyWeight.reduce((a, b) => a > b ? a : b) + 5;
  double get maxYearly => yearlyWeight.reduce((a, b) => a > b ? a : b) + 5;

  /// Weekly Chart (Bar)
  String _weeklyChartOption() => '''
  {
    tooltip: { trigger: 'axis' },
    animation: true,
    animationDuration: 500,
    animationEasing: 'cubicOut',
    xAxis: {
      type: 'category',
      data: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'],
      axisTick: { show: false },
      axisLine: { lineStyle: { color: '#999' } },
      axisLabel: { color: '#666' }
    },
    yAxis: {
      type: 'value',
      min: 50,
      max: $maxWeekly,
      axisLine: { lineStyle: { color: '#999' } },
      axisLabel: { formatter: '{value}kg', color: '#666' },
      splitLine: { lineStyle: { color: '#eee' } }
    },
    series: [{
      data: ${weeklyWeight.toString()},
      type: 'bar',
      barWidth: 30,
      itemStyle: { color: '#9B2354', borderRadius: [6, 6, 0, 0] }
    }],
    grid: { left: '5%', right: '5%', bottom: '10%', top: '5%', containLabel: true }
  }
  ''';

  /// Monthly Chart (Bar)
  String _monthlyChartOption() => '''
  {
    tooltip: { trigger: 'axis' },
    animation: true,
    animationDuration: 500,
    animationEasing: 'cubicOut',
    xAxis: {
      type: 'category',
      data: ['Week 1','Week 2','Week 3','Week 4'],
      axisTick: { show: false },
      axisLine: { lineStyle: { color: '#999' } },
      axisLabel: { color: '#666' }
    },
    yAxis: {
      type: 'value',
      min: 50,
      max: $maxMonthly,
      axisLine: { lineStyle: { color: '#999' } },
      axisLabel: { formatter: '{value}kg', color: '#666' },
      splitLine: { lineStyle: { color: '#eee' } }
    },
    series: [{
      data: ${monthlyWeight.toString()},
      type: 'bar',
      barWidth: 35,
      itemStyle: { color: '#9B2354', borderRadius: [6, 6, 0, 0] }
    }],
    grid: { left: '5%', right: '5%', bottom: '10%', top: '5%', containLabel: true }
  }
  ''';

  /// Yearly Chart (Line)
  String _yearlyChartOption() => '''
  {
    tooltip: { trigger: 'axis' },
    animation: true,
    animationDuration: 1000,
    animationEasing: 'cubicOut',
    xAxis: {
      type: 'category',
      data: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
      axisTick: { show: false },
      axisLine: { lineStyle: { color: '#999' } },
      axisLabel: { color: '#666' }
    },
    yAxis: {
      type: 'value',
      min: 50,
      max: $maxYearly,
      axisLine: { lineStyle: { color: '#999' } },
      axisLabel: { formatter: '{value}kg', color: '#666' },
      splitLine: { lineStyle: { color: '#eee' } }
    },
    series: [{
      data: ${yearlyWeight.toString()},
      type: 'line',
      smooth: true,
      symbol: 'circle',
      symbolSize: 10,
      lineStyle: { color: '#9B2354', width: 3 },
      itemStyle: { color: '#9B2354' }
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
                fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
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
                    width: 100, height: 30, color: const Color(0xFF9B2354)),
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

  /// Stats cards
  Widget _buildStatsCards() {
    double bmi = calculateBMI();
    double weightChange = currentWeight - goalWeight;
    bool isLosing = currentWeight > goalWeight;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              _statCard("Current Weight",
                  "${currentWeight.toStringAsFixed(1)} kg", Colors.black),
              const SizedBox(width: 10),
              _statCard(
                "Weight ${isLosing ? 'Loss' : 'Gain'}",
                "${weightChange.abs().toStringAsFixed(1)} kg",
                isLosing ? Colors.red : Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _statCard("BMI", "${bmi.toStringAsFixed(1)}", Colors.orange),
              const SizedBox(width: 12),
              _statCard("Target Weight", "${goalWeight.toStringAsFixed(1)} kg",
                  Colors.purple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title at top-left
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),

            // Value
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Weight tracker',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'AudioLinkMono',
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildChartSection(),
            const SizedBox(height: 10),
            _buildStatsCards(),
          ],
        ),
      ),
    );
  }
}
