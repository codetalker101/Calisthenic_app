import 'package:calisthenics_app/features/progress/presentation/calories/calories_tracker.dart';
import 'package:calisthenics_app/features/progress/presentation/logs_activities.dart';
import 'package:calisthenics_app/features/progress/presentation/macronutrients/macronutrients_tracker.dart';
import 'package:calisthenics_app/features/progress/presentation/sleep/sleep_tracker.dart';
import 'package:calisthenics_app/features/progress/presentation/water/water_tracker.dart';
import 'package:calisthenics_app/features/progress/presentation/weight/weight_tracker.dart';
import 'package:calisthenics_app/features/progress/presentation/workout_log/workout_tracker.dart';
import 'package:calisthenics_app/features/progress/presentation/schedules/schedules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProgressPage extends StatefulWidget {
  final List<NeatCleanCalendarEvent> events;

  const ProgressPage({
    super.key,
    this.events = const [],
  });

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  late List<NeatCleanCalendarEvent> _events;
  DateTime _currentMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
    _events = widget.events;
  }

  void _updateEvents(List<NeatCleanCalendarEvent> newEvents) {
    setState(() {
      _events = newEvents;
    });
  }

  /// AppBar
  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 1,
      title: const Text(
        'Progress',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: 'AudioLinkMono',
          color: Colors.black,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (_) => LogsActivitiesPage()),
              );
            },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/logsIcon.svg',
                  width: 30,
                  height: 30,
                  color: Color(0xFF4A4A4A),
                ),
              ),
            ),
          ),
        ),
      ],
      backgroundColor: const Color(0xFFECE6EF),
    );
  }

  /// Calendar Section
  Widget _buildCalendarSection(double screenWidth, double screenHeight) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      height: screenHeight * 0.43,
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.06),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsetsDirectional.only(start: 10),
              child: Text(
                "Schedules",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "SF-Pro-Display-Thin",
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const Divider(thickness: 1, color: Colors.black26, height: 20),
            Expanded(
              child: Calendar(
                startOnMonday: true,
                weekDays: const [
                  'Mon',
                  'Tue',
                  'Wed',
                  'Thu',
                  'Fri',
                  'Sat',
                  'Sun'
                ],
                showEvents: false,
                eventsList: _events,
                isExpandable: false,
                isExpanded: true,
                eventDoneColor: Colors.green,
                selectedColor: const Color(0xFF9B2354),
                selectedTodayColor: const Color(0xFF9B2354),
                todayColor: const Color(0xFF9B2354),
                locale: 'en_US',
                todayButtonText: 'Today',
                allDayEventText: 'All Day',
                expandableDateFormat: 'EEEE, dd MMMM yyyy',
                datePickerType: DatePickerType.date,
                showEventListViewIcon: true,
                onDateSelected: (selectedDate) {
                  final normalized = DateTime(
                      selectedDate.year, selectedDate.month, selectedDate.day);
                  if (normalized.month == _currentMonth.month &&
                      normalized.year == _currentMonth.year) {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (_) => SchedulePage(
                          selectedDate: normalized,
                          onEventsUpdated: _updateEvents,
                        ),
                      ),
                    );
                  } else {
                    setState(() {
                      _currentMonth =
                          DateTime(normalized.year, normalized.month);
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Macro Nutrients Card
  Widget _buildMacroNutrientsCard(double screenWidth, double screenHeight) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (_) => MacroNutrientsPage()),
        );
      },
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(screenWidth * 0.06),
        color: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          height: screenHeight * 0.16,
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.010, horizontal: screenWidth * 0.05),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.06),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              const Text(
                "Macro nutrients",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "SF-Pro-Display-Thin",
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 35),
              Expanded(
                child: Row(
                  children: [
                    _buildNutrientColumn(
                        "Protein", 66, 120, Color(0xFF9B2354), screenHeight),
                    SizedBox(width: screenWidth * 0.03),
                    _buildNutrientColumn(
                        "Carbs", 700, 2500, Colors.green, screenHeight),
                    SizedBox(width: screenWidth * 0.03),
                    _buildNutrientColumn(
                        "Fat", 40, 70, Colors.orange, screenHeight),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutrientColumn(String label, double value, double goal,
      Color color, double screenHeight) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
          SizedBox(height: screenHeight * 0.008),
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
          Text("$value/$goal g",
              style: const TextStyle(fontSize: 10.5, color: Colors.black54)),
        ],
      ),
    );
  }

  /// Weight Tracker Card
  Widget _buildWeightCard(double screenWidth) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (_) => WeightPage()),
        );
      },
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(25),
        color: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          height: screenWidth * 0.3,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              const Text(
                "Weight tracker",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "SF-Pro-Display-Thin",
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("72 kg",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      SizedBox(height: 4),
                      Text("Current",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("+2.5 kg",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.green)),
                      SizedBox(height: 4),
                      Text("Gain/Loss",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("75 kg",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      SizedBox(height: 4),
                      Text("Goal",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("20.0",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      SizedBox(height: 4),
                      Text("BMI",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Progress Card Row (2 cards side by side)
  Widget _buildProgressCardRow(Widget leftCard, Widget rightCard) {
    return Row(
      children: [
        Expanded(child: leftCard),
        const SizedBox(
          width: 5,
          height: 5,
        ), // small gap between the 2 cards
        Expanded(child: rightCard),
      ],
    );
  }

  Widget _buildCaloriesCard(double screenWidth) {
    return _buildColoredCard(
      screenWidth,
      Color(0xFF9B2354),
      'assets/icons/CaloriesBurntIcon.svg',
      "450 kcal",
      "Calories Burnt",
      Colors.white,
      () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (_) => CaloriesBurnedPage()),
      ),
    );
  }

  Widget _buildWaterCard(double screenWidth) {
    return _buildColoredCard(
      screenWidth,
      Color(0xFF26AAC7),
      'assets/icons/WaterIcons.svg',
      "500/3700 ml",
      "Water",
      Colors.black,
      () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (_) => WaterTrackerPage()),
      ),
    );
  }

  Widget _buildSleepCard(double screenWidth) {
    return _buildColoredCard(
      screenWidth,
      Color(0xFF763EB0),
      'assets/icons/SleepIcon.svg',
      "7.5 Hours/day",
      "Sleep Tracker",
      Colors.white,
      () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (_) => SleepTrackerPage()),
      ),
    );
  }

  Widget _buildWorkoutCard(double screenWidth) {
    return _buildColoredCard(
      screenWidth,
      Color(0xFFFAA34D),
      'assets/icons/WorkoutIcons2.svg',
      "5",
      "Workouts",
      Colors.black,
      () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (_) => WorkoutTrackerPage()),
      ),
    );
  }

  Widget _buildColoredCard(
    double screenWidth,
    Color bgColor,
    String iconPath,
    String value,
    String label,
    Color textColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(25),
        color: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          height: screenWidth * 0.35, // 🔹 keep original size
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: SvgPicture.asset(
                  iconPath,
                  width: 25,
                  height: 25,
                  color: textColor,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.more_horiz, color: textColor),
                  onPressed: () {},
                ),
              ),
              Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: textColor.withOpacity(0.85),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCalendarSection(screenWidth, screenHeight),
                _buildMacroNutrientsCard(screenWidth, screenHeight),
                const SizedBox(height: 10),
                _buildWeightCard(screenWidth),
                const SizedBox(height: 10),
                _buildProgressCardRow(
                  _buildCaloriesCard(screenWidth),
                  _buildWaterCard(screenWidth),
                ),
                const SizedBox(height: 8),
                _buildProgressCardRow(
                  _buildSleepCard(screenWidth),
                  _buildWorkoutCard(screenWidth),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
