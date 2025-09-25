import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:calisthenics_app/features/progress/presentation/water/reminder.dart';

class WaterTrackerPage extends StatefulWidget {
  const WaterTrackerPage({super.key});

  @override
  State<WaterTrackerPage> createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage>
    with SingleTickerProviderStateMixin {
  // Water Data
  int waterIntake = 1200;
  final int goal = 3700;
  List<Map<String, dynamic>> waterLogs = [];
  List<int> weeklyIntake = [1800, 1500, 2000, 1200, 1700, 2000, 1300];

  // Animation Controller for wave
  late final AnimationController _waveController;
  double displayedPercent = 0;

  // store reminders passed from ReminderPage
  List<DateTime> _reminders = [];

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        displayedPercent = (waterIntake / goal).clamp(0.0, 1.0);
      });
    });
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  // Add water
  void _addWater(int amount) {
    setState(() {
      waterIntake += amount;
      if (waterIntake > goal) waterIntake = goal;
      waterLogs.insert(0, {"amount": amount, "time": DateTime.now()});
      displayedPercent = (waterIntake / goal).clamp(0.0, 1.0);
    });
  }

  // Reset water
  void _reset() {
    setState(() {
      waterIntake = 0;
      displayedPercent = 0;
      waterLogs.clear();
    });
  }

  /// Water Intake Chart Options
  String _waterIntakeChartOption(List<int> weeklyIntake) => '''
  {
    animationDuration: 500,   // default ~1000ms
    animationEasing: 'cubicOut', // smoother but quick ease
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
  ''';

  /// AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 1,
      title: const Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Water tracker',
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
              option: _waterIntakeChartOption(weeklyIntake),
            ),
          ),
          const Divider(height: 1, thickness: 0.8),
          const SizedBox(height: 18),
          _buildWaterButtons(),
        ],
      ),
    );
  }

  /// Water Intake + Reset Buttons
  Widget _buildWaterButtons() {
    return Center(
      child: SizedBox(
        width: 330,
        height: 30,
        child: Material(
          elevation: 0,
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xFF26AAC7),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            children: [
              for (var amount in [50, 100, 250]) ...[
                Expanded(
                  child: GestureDetector(
                    onTap: () => _addWater(amount),
                    child: Center(
                      child: Text(
                        "+$amount ml",
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                if (amount != 250)
                  Container(width: 1, height: 22, color: Colors.white),
              ],
              Container(width: 1, height: 22, color: Colors.white),
              Expanded(
                child: GestureDetector(
                  onTap: _reset,
                  child: const Center(
                    child: Text(
                      "Reset",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reminder Card (water intake card separated on it's own class "reason? kinda because it's complexity")
  Widget _buildReminderCard() {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push<List<DateTime>>(
          context,
          MaterialPageRoute(builder: (_) => const ReminderPage()),
        );
        if (result != null) {
          setState(() {
            _reminders = result;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Reminder",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Icon(Icons.alarm, color: Color(0xFFFF7043), size: 60),
              SizedBox(height: 5),
              Text(
                "Drink water every 2 hrs!",
                style: TextStyle(fontSize: 11, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Stats Row: Water Intake + Reminder
  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.35,
              child: WaterIntakeCard(
                waterIntake: waterIntake,
                goal: goal,
                controller: _waveController,
                displayedPercent: displayedPercent,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.35,
              child: _buildReminderCard(),
            ),
          ),
        ],
      ),
    );
  }

  /// Today's Record Section
  Widget _buildTodaysRecord() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Record",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 15),

          // card-like container
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  _nextReminderRow(),
                  ..._buildWaterLogRows(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nextReminderRow() {
    // pick nearest reminder after now
    DateTime? nextReminder;
    final now = DateTime.now();

    if (_reminders.isNotEmpty) {
      _reminders.sort((a, b) => a.compareTo(b));
      nextReminder = _reminders.firstWhere(
        (reminder) => reminder.isAfter(now),
        orElse: () => _reminders.first, // fallback
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              "assets/icons/clockReminder.svg",
              width: 20,
              height: 20,
              colorFilter:
                  const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
            if (waterLogs.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                height: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    4,
                    (i) => Container(
                      width: 3,
                      height: 3,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Next reminder",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "SF-Pro-Display-Thin",
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4A4A4A),
                ),
              ),
              Row(
                children: [
                  Text(
                    nextReminder != null
                        ? DateFormat("h:mm a").format(nextReminder)
                        : "No reminder",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                  const SizedBox(width: 15),
                  SvgPicture.asset(
                    "assets/icons/pencilEdit.svg",
                    width: 18,
                    height: 18,
                    colorFilter: const ColorFilter.mode(
                        Color(0xFF4A4A4A), BlendMode.srcIn),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildWaterLogRows() {
    return List.generate(waterLogs.length, (index) {
      final log = waterLogs[index];
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SvgPicture.asset(
                "assets/icons/waterGlass.svg",
                width: 20,
                height: 20,
                colorFilter:
                    const ColorFilter.mode(Color(0xFF26AAC7), BlendMode.srcIn),
              ),
              if (waterLogs.length > 1 && index != waterLogs.length - 1)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  height: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      4,
                      (i) => Container(
                        width: 3,
                        height: 3,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF4A4A4A),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${log['amount']} ml",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      DateFormat("h:mm a").format(log['time']),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () => setState(() => waterLogs.removeAt(index)),
                      child: SvgPicture.asset(
                        "assets/icons/trashBin.svg",
                        width: 18,
                        height: 18,
                        colorFilter: const ColorFilter.mode(
                            Colors.black, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
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
            _buildStatsRow(),
            const SizedBox(height: 20),
            _buildTodaysRecord(),
          ],
        ),
      ),
    );
  }
}

// Water Intake Card
class WaterIntakeCard extends StatelessWidget {
  final int waterIntake;
  final int goal;
  final AnimationController controller;
  final double displayedPercent;

  const WaterIntakeCard({
    super.key,
    required this.waterIntake,
    required this.goal,
    required this.controller,
    required this.displayedPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          alignment: Alignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: displayedPercent),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              builder: (context, percent, _) {
                return AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) {
                    return CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, 180),
                      painter: _WavePainter(
                          animationValue: controller.value, percent: percent),
                    );
                  },
                );
              },
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Water Intake",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    const Icon(Icons.local_drink,
                        color: Color(0xFF26AAC7), size: 30),
                    const SizedBox(height: 8),
                    Text(
                      "$waterIntake / $goal ml",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF076D8C)),
                    ),
                    Text(
                      "${(displayedPercent * 100).toStringAsFixed(1)}% of goal",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54),
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

// Wave Painter
class _WavePainter extends CustomPainter {
  final double animationValue;
  final double percent;

  _WavePainter({required this.animationValue, required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF26AAC7).withOpacity(0.6);
    double baseHeight = size.height * (1 - percent);
    Path path = Path()..moveTo(0, baseHeight);

    for (double x = 0; x <= size.width; x++) {
      double y = baseHeight +
          8 * sin((2 * pi * (x / size.width)) + (animationValue * 2 * pi));
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter oldDelegate) => true;
}
