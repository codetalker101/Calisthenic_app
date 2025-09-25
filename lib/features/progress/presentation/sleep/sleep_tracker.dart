import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SleepTrackerPage extends StatefulWidget {
  const SleepTrackerPage({super.key});

  @override
  State<SleepTrackerPage> createState() => _SleepTrackerPageState();
}

class _SleepTrackerPageState extends State<SleepTrackerPage> {
  // Sleep Data
  final double sleepGoal = 8;
  final double todaySleep = 6.5;

  TimeOfDay wentToSleep = const TimeOfDay(hour: 22, minute: 45);
  TimeOfDay wokeUp = const TimeOfDay(hour: 6, minute: 30);

  final List<double> weeklySleep = [7, 6.5, 8, 5, 7.5, 6, 8.5];
  final List<double> weeklySleepTimeNumeric = [
    23.0,
    24.5,
    22.75,
    25.25,
    23.25,
    24.0,
    6.5
  ];
  final List<double> weeklyWakeTimeNumeric = [
    7.0,
    8.0,
    7.5,
    6.75,
    8.25,
    7.0,
    13.5
  ];

  int selectedChart = 0; // 0 = duration, 1 = sleep/wake time

  /// Time Picker
  Future<void> _selectTime(bool isSleepTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isSleepTime ? wentToSleep : wokeUp,
    );

    if (picked != null) {
      setState(() {
        if (isSleepTime) {
          wentToSleep = picked;
        } else {
          wokeUp = picked;
        }
      });
    }
  }

  /// Format TimeOfDay -> String
  String _formatTimeOfDay(TimeOfDay tod) {
    final hour = tod.hourOfPeriod == 0 ? 12 : tod.hourOfPeriod;
    final minute = tod.minute.toString().padLeft(2, '0');
    final period = tod.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$minute $period";
  }

  // Echarts Options
  String _durationChartOption() => '''
  {
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
      min: 0,
      max: 10,
      axisLine: { lineStyle: { color: '#999' } },
      axisLabel: { formatter: '{value}h', color: '#666' },
      splitLine: { lineStyle: { color: '#eee' } }
    },
    series: [
      {
        data: ${weeklySleep.toString()},
        type: 'bar',
        barWidth: 30,
        itemStyle: {
          color: '#763EB0',
          borderRadius: [6, 6, 0, 0]
        }
      }
    ],
    grid: {
      left: '5%',
      right: '5%',
      bottom: '10%',
      top: '5%',
      containLabel: true
    }
  }
  ''';

  String _sleepWakeChartOption() => '''
  {
    tooltip: {
      trigger: 'axis',
      formatter: function(params) {
        var result = params[0].axisValue + '<br/>';
        params.forEach(function(item) {
          var hours = Math.floor(item.value > 24 ? item.value - 24 : item.value);
          var minutes = Math.round((item.value % 1) * 60);
          var timeStr = hours.toString().padStart(2, '0') + ':' +
                        minutes.toString().padStart(2, '0');
          if (item.value > 24) timeStr += ' (next day)';
          result += item.marker + ' ' + item.seriesName + ': ' + timeStr + '<br/>';
        });
        return result;
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
      max: 28,
      interval: 2,
      axisLine: { lineStyle: { color: '#999' } },
      axisLabel: {
        color: '#666',
        formatter: function(value) {
          return (value >= 24 ? (value - 24) : value)
                   .toString().padStart(2,'0') + ':00';
        }
      },
      splitLine: { lineStyle: { color: '#eee' } }
    },
    legend: {
      data: ['Sleep Time','Wake Time'],
      bottom: 10,
      left: '50%',
      textStyle: { color: '#666', fontSize: 9 }
    },
    series: [
      {
        name: 'Sleep Time',
        data: ${weeklySleepTimeNumeric.toString()},
        type: 'line',
        symbol: 'circle',
        symbolSize: 10,
        itemStyle: { color: '#763EB0' },
        lineStyle: { color: '#763EB0', width: 2 },
        smooth: true
      },
      {
        name: 'Wake Time',
        data: ${weeklyWakeTimeNumeric.toString()},
        type: 'line',
        symbol: 'circle',
        symbolSize: 10,
        itemStyle: { color: '#FFD700' },
        lineStyle: { color: '#FFD700', width: 2 },
        smooth: true
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
      scrolledUnderElevation: 1,
      title: const Align(
        alignment: Alignment.centerRight,
        child: Text(
          'Sleep tracker',
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
      option:
          selectedChart == 0 ? _durationChartOption() : _sleepWakeChartOption(),
    );
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
                    width: 140, height: 30, color: const Color(0xFF763EB0)),
              ),
            ),
            Row(
              children: [
                _toggleButton("assets/icons/sleepZzz.svg", "Sleep Duration", 0),
                _toggleButton("assets/icons/alarm.svg", "Sleep/Wake Time", 1),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleButton(String iconPath, String label, int index) {
    final isSelected = selectedChart == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedChart = index),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 14,
                height: 14,
                colorFilter: ColorFilter.mode(
                  isSelected ? Colors.white : Colors.black87,
                  BlendMode.srcIn,
                ),
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
              Icons.bedtime,
              const Color(0xFF763EB0),
              _formatTimeOfDay(wentToSleep),
              "Went to Sleep",
              "Sleep Time",
              true,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _statCard(
              Icons.wb_sunny,
              const Color(0xFFFFD700),
              _formatTimeOfDay(wokeUp),
              "Woke Up",
              "Wake Time",
              false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(IconData icon, Color color, String value, String label,
      String title, bool isSleepTime) {
    return GestureDetector(
      onTap: () => _selectTime(isSleepTime),
      child: Container(
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
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
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
