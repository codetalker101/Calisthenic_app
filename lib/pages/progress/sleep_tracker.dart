import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SleepTrackerPage extends StatefulWidget {
  const SleepTrackerPage({super.key});

  @override
  State<SleepTrackerPage> createState() => _SleepTrackerPageState();
}

class _SleepTrackerPageState extends State<SleepTrackerPage> {
  double sleepGoal = 8; // hours
  double todaySleep = 6.5; // hours

  // 🔹 Added missing variables
  String wentToSleep = "10:45 PM";
  String wokeUp = "06:30 AM";

  List<double> weeklySleep = [7, 6.5, 8, 5, 7.5, 6, 8.5]; // duration in hours

  List<double> weeklySleepTimeNumeric = [
    23.0,
    24.5,
    22.75,
    25.25,
    23.25,
    24.0,
    23.5
  ];

  List<double> weeklyWakeTimeNumeric = [7.0, 8.0, 7.5, 6.75, 8.25, 7.0, 8.5];

  List<String> weeklySleepTime = [
    "23:00",
    "00:30",
    "22:45",
    "01:15",
    "23:15",
    "00:00",
    "23:30"
  ];

  List<String> weeklyWakeTime = [
    "07:00",
    "08:00",
    "07:30",
    "06:45",
    "08:15",
    "07:00",
    "08:30"
  ];

  int selectedChart = 0; // 0 = duration, 1 = sleep/wake time

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
              'Sleep tracker',
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

                  // Chart
                  SizedBox(
                    height: 260,
                    child: Echarts(
                      option: selectedChart == 0
                          ? '''
                        {
                          xAxis: {
                            type: 'category',
                            data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                            axisTick: { show: false },
                            axisLine: { lineStyle: { color: '#999' } },
                            axisLabel: { color: '#666' }
                          },
                          yAxis: {
                            type: 'value',
                            min: 0,
                            max: 10,
                            axisLine: { lineStyle: { color: '#999' } },
                            axisLabel: {
                              formatter: '{value}h',
                              color: '#666'
                            },
                            splitLine: { lineStyle: { color: '#eee' } }
                          },
                          series: [{
                            data: ${weeklySleep.toString()},
                            type: 'bar',
                            barWidth: 30,
                            itemStyle: {
                              color: '#763EB0',
                              borderRadius: [6, 6, 0, 0]
                            },
                            label: {
                              show: false,
                              position: 'top',
                              formatter: '{c}h',
                              color: '#666'
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
                      '''
                          : '''
                        {
                          tooltip: {
                            trigger: 'axis',
                            formatter: function(params) {
                              var result = params[0].axisValue + '<br/>';
                              params.forEach(function(item) {
                                var hours = Math.floor(item.value > 24 ? item.value - 24 : item.value);
                                var minutes = Math.round((item.value % 1) * 60);
                                var timeStr = hours.toString().padStart(2, '0') + ':' + minutes.toString().padStart(2, '0');
                                if (item.value > 24) timeStr += ' (next day)';
                                result += item.marker + ' ' + item.seriesName + ': ' + timeStr + '<br/>';
                              });
                              return result;
                            }
                          },
                          xAxis: {
                            type: 'category',
                            data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
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
                                if (value >= 24) {
                                  var hour = value - 24;
                                  return hour.toString().padStart(2, '0') + ':00';
                                } else {
                                  return value.toString().padStart(2, '0') + ':00';
                                }
                              }
                            },
                            splitLine: { lineStyle: { color: '#eee' } }
                          },
                          legend: {
                            data: ['Sleep Time', 'Wake Time'],
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
                      ''',
                    ),
                  ),

                  const SizedBox(height: 5),

                  // 🔹 Custom Toggle Buttons (moved beneath chart)
                  Center(
                    child: SizedBox(
                      width: 280,
                      height: 30,
                      child: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFFECE6EF),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Stack(
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              transitionBuilder: (child, animation) =>
                                  FadeTransition(
                                      opacity: animation, child: child),
                              child: Align(
                                key: ValueKey<int>(selectedChart),
                                alignment: selectedChart == 0
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: Container(
                                  width: 280 / 2,
                                  height: 30,
                                  color: const Color(0xFF763EB0),
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
                                            "assets/icons/sleepZzz.svg",
                                            width: 14,
                                            height: 14,
                                            color: selectedChart == 0
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "Sleep Duration",
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
                                            "assets/icons/alarm.svg",
                                            width: 14,
                                            height: 14,
                                            color: selectedChart == 1
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "Sleep/Wake Time",
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 Sleep Statistics Cards
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
                          Row(
                            children: [
                              const Icon(Icons.bedtime,
                                  color: Color(0xFF763EB0), size: 30),
                              const SizedBox(width: 8),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            wentToSleep, // e.g. "10:45 PM"
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF763EB0),
                            ),
                          ),
                          Text(
                            "Went to Sleep",
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
                          Row(
                            children: [
                              const Icon(Icons.wb_sunny,
                                  color: Color(0xFFFFD700), size: 30),
                              const SizedBox(width: 8),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            wokeUp, // e.g. "06:30 AM"
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFD700),
                            ),
                          ),
                          Text(
                            "Woke Up",
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
