import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class MacroNutrientsPage extends StatefulWidget {
  const MacroNutrientsPage({super.key});

  @override
  State<MacroNutrientsPage> createState() => _MacroNutrientsPageState();
}

class _MacroNutrientsPageState extends State<MacroNutrientsPage> {
  // Dummy Data
  final int protein = 90;
  final int proteinGoal = 120;
  final int carbs = 180;
  final int carbsGoal = 250;
  final int fats = 60;
  final int fatsGoal = 80;

  int selectedChart = 0; // 0 = Protein, 1 = Carbs, 2 = Fats

  // Combined Macro Nutrients Line Chart
  String _macroChartOption() => '''
  {
    animationDuration: 500,
    animationEasing: 'cubicOut',
    tooltip: {
      trigger: 'axis',
      axisPointer: { type: 'line' }
    },
    legend: {
      data: ['Protein', 'Carbs', 'Fats'],
      bottom: 10,
      left: '44%',
      textStyle: { color: '#666', fontSize: 9 }
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
      max: 300,
      axisLine: { lineStyle: { color: '#999' } },
      axisLabel: { formatter: '{value}g', color: '#666' },
      splitLine: { lineStyle: { color: '#eee' } }
    },
    series: [
      {
        name: 'Protein',
        data: [90, 100, 120, 80, 110, 95, 105],
        type: 'line',
        symbol: 'circle',
        symbolSize: 10,
        smooth: true,
        lineStyle: { color: '#9B2354', width: 3 },
        itemStyle: { color: '#9B2354' }
      },
      {
        name: 'Carbs',
        data: [180, 200, 220, 150, 250, 190, 210],
        type: 'line',
        symbol: 'circle',
        symbolSize: 10,
        smooth: true,
        lineStyle: { color: 'green', width: 3 },
        itemStyle: { color: 'green' }
      },
      {
        name: 'Fats',
        data: [60, 70, 65, 55, 80, 75, 68],
        type: 'line',
        symbol: 'circle',
        symbolSize: 10,
        smooth: true,
        lineStyle: { color: 'orange', width: 3 },
        itemStyle: { color: 'orange' }
      }
    ],
    grid: {
      left: '5%',
      right: '5%',
      bottom: '15%',
      top: '5%',
      containLabel: true
    }
  }
  ''';

  /// AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: const Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Macro Nutrients Tracker',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'AudioLinkMono',
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  /// Chart Section (replaces calendar)
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
              fontSize: 12,
              fontFamily: "SF-Pro-Display-Thin",
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 260,
            child: Echarts(
              option: _macroChartOption(),
            ),
          ),
        ],
      ),
    );
  }

  /// Macro Nutrients Section
  Widget _buildMacroNutrientsSection(double screenWidth, double screenHeight) {
    Widget nutrientColumn(
        String label, int value, int goal, Color color, double screenHeight) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.018),
            Text(label,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            SizedBox(height: screenHeight * 0.010),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: LinearProgressIndicator(
                value: value / goal,
                minHeight: 6,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            SizedBox(height: screenHeight * 0.008),
            Text(
              "$value/$goal g",
              style: const TextStyle(fontSize: 10.5, color: Colors.black54),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      width: double.infinity,
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(screenWidth * 0.06),
        color: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          height: screenHeight * 0.13,
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.020,
            horizontal: screenWidth * 0.05,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.06),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              nutrientColumn("Protein", protein, proteinGoal,
                  const Color(0xFF9B2354), screenHeight),
              SizedBox(width: screenWidth * 0.03),
              nutrientColumn(
                  "Carbs", carbs, carbsGoal, Colors.green, screenHeight),
              SizedBox(width: screenWidth * 0.03),
              nutrientColumn(
                  "Fat", fats, fatsGoal, Colors.orange, screenHeight),
            ],
          ),
        ),
      ),
    );
  }

  /// Meals Section
  Widget _buildMealsSection(double screenWidth, double screenHeight) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFECE6EF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Nutrients sources",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildMealCard("Egg Sandwich", "450 kcal", 20, 60, 10,
                        screenWidth, screenHeight),
                    _buildMealCard("Fried Chicken", "650 kcal", 30, 80, 20,
                        screenWidth, screenHeight),
                    _buildMealCard("Milk Shake", "350 kcal", 25, 40, 15,
                        screenWidth, screenHeight),
                    _buildMealCard("L-men protein bar", "0 kcal", 0, 0, 0,
                        screenWidth, screenHeight),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealCard(
    String title,
    String kcal,
    int protein,
    int carbs,
    int fat,
    double screenWidth,
    double screenHeight,
  ) {
    return Container(
      height: screenHeight * 0.10,
      width: screenWidth * 0.95,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          const Icon(Icons.restaurant_menu, color: Color(0xFF9B2354), size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text("$protein g protein",
                        style: const TextStyle(
                            fontSize: 10, color: Colors.black54)),
                    const SizedBox(width: 13),
                    Text("$carbs g carbs",
                        style: const TextStyle(
                            fontSize: 10, color: Colors.black54)),
                    const SizedBox(width: 13),
                    Text("$fat g fats",
                        style: const TextStyle(
                            fontSize: 10, color: Colors.black54)),
                  ],
                ),
              ],
            ),
          ),
          Text(
            kcal,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildChartSection(), // 🔹 replaced calendar
          const SizedBox(height: 8),
          _buildMacroNutrientsSection(screenWidth, screenHeight),
          _buildMealsSection(screenWidth, screenHeight),
        ],
      ),
    );
  }
}
