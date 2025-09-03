import 'package:calisthenics_app/pages/progress/calories_tracker.dart';
import 'package:calisthenics_app/pages/progress/sleep_tracker.dart';
import 'package:calisthenics_app/pages/progress/water_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import '../../pages/profile/profile.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        title: const Text(
          'Progress',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'AudioLinkMono',
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFECE6EF),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 9.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const ProfilePage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: ClipOval(
                child: Image.asset(
                  'assets/icons/saitama-profile-pic.png',
                  width: screenWidth * 0.13,
                  height: screenHeight * 0.13,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.035,
            vertical: screenHeight * 0.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Calendar
                Material(
                  elevation: 0,
                  borderRadius: BorderRadius.circular(screenWidth * 0.06),
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    height: screenHeight * 0.38,
                    margin:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.06),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.025),
                      child: MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaler: TextScaler.noScaling),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(),
                          ),
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
                            eventsList: const [],
                            isExpandable: false,
                            isExpanded: true,
                            eventDoneColor: Colors.green,
                            selectedColor: const Color(0xFF9B2354),
                            selectedTodayColor: const Color(0xFF9B2354),
                            todayColor: const Color(0xFF9B2354),
                            locale: 'en_US',
                            todayButtonText: 'Today',
                            allDayEventText: 'All Day',
                            multiDayEndText: 'End',
                            expandableDateFormat: 'EEEE, dd MMMM yyyy',
                            datePickerType: DatePickerType.date,
                            showEventListViewIcon: false,
                            dayOfWeekStyle: TextStyle(
                              color: Color(0xFF9B2354),
                              fontWeight: FontWeight.w800,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                            ),
                            displayMonthTextStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.001),

                // Macros Nutrients Card
                Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(screenWidth * 0.06),
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    height: screenHeight * 0.1,
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.017,
                        horizontal: screenWidth * 0.05),
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
                        // Protein
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Protein",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.03,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.008),
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.02),
                                child: LinearProgressIndicator(
                                  value: 66 / 120,
                                  minHeight: screenHeight * 0.007,
                                  backgroundColor: Colors.grey.shade300,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Color(0xFF9B2354)),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.008),
                              Text(
                                "66/120 g",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.025,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        // Carbs
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Carbs",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.03,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.008),
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.02),
                                child: LinearProgressIndicator(
                                  value: 200 / 300,
                                  minHeight: screenHeight * 0.007,
                                  backgroundColor: Colors.grey.shade300,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.green),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.008),
                              Text(
                                "200/300 g",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.025,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        // Fat
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Fat",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.03,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.008),
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.02),
                                child: LinearProgressIndicator(
                                  value: 40 / 70,
                                  minHeight: screenHeight * 0.007,
                                  backgroundColor: Colors.grey.shade300,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.orange),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.008),
                              Text(
                                "40/70 g",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.025,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Weight Gain/Loss Card wrapped in Material
                Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Container(
                    height: screenWidth * 0.3,
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
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
                        // Header Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Weight Gain",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "SF-Pro-Display-Thin",
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.more_horiz,
                                  color: Colors.black54),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Weight Details
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "72 kg",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "SF-Pro-Display-Thin",
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Current",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "SF-Pro-Display-Thin",
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "+2.5 kg",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "SF-Pro-Display-Thin",
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Gain/Loss",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "SF-Pro-Display-Thin",
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "75 kg",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "SF-Pro-Display-Thin",
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Goal",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "SF-Pro-Display-Thin",
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Two cards in the same row (Calories Burnt and Water)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Row(
                    children: [
                      // Calories Burnt Card
                      Expanded(
                        child: Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xFF9B2354),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            height: screenWidth * 0.35,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: SvgPicture.asset(
                                    'assets/icons/CaloriesBurntIcon.svg',
                                    width: 25,
                                    height: 25,
                                    color: Colors.white,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.more_horiz,
                                        color: Colors.white),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .push(
                                        MaterialPageRoute(
                                          builder: (_) => CaloriesBurnedPage(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                // Horizontally centered, vertically near bottom
                                Positioned(
                                  bottom: 15, // distance from bottom of card
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "450 kcal",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "SF-Pro-Display-Thin",
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Calories Burnt",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "SF-Pro-Display-Thin",
                                          color: Colors.white,
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
                      ),

                      const SizedBox(width: 10),

                      // Water per day Card
                      Expanded(
                        child: Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xFF26AAC7),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            height: screenWidth * 0.35,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: SvgPicture.asset(
                                    'assets/icons/WaterIcons.svg',
                                    width: 25,
                                    height: 25,
                                    color: Colors.black,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.more_horiz,
                                        color: Colors.black),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .push(
                                        MaterialPageRoute(
                                          builder: (_) => WaterTrackerPage(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                // Horizontally centered, vertically near bottom
                                Positioned(
                                  bottom: 15,
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "500/3700 ml",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "SF-Pro-Display-Thin",
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Water",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "SF-Pro-Display-Thin",
                                          color: Colors.black54,
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
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5),

                // Two cards in same row Sleep Tracker and Workout tracker
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Row(
                    children: [
                      // Sleep Tracker Card
                      Expanded(
                        child: Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.transparent,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            height: screenWidth * 0.35,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFF763EB0),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: SvgPicture.asset(
                                    'assets/icons/SleepIcon.svg',
                                    width: 28,
                                    height: 28,
                                    color: Colors.white,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.more_horiz,
                                        color: Colors.white),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .push(
                                        MaterialPageRoute(
                                          builder: (_) => SleepTrackerPage(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                // Horizontally centered, vertically near bottom
                                Positioned(
                                  bottom: 15,
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "7.5 Hours/day",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "SF-Pro-Display-Thin",
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Sleep Tracker",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "SF-Pro-Display-Thin",
                                          color: Colors.white,
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
                      ),

                      const SizedBox(width: 10),

                      // Workouts per day Card
                      Expanded(
                        child: Material(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.transparent,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            height: screenWidth * 0.35,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAA34D),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: SvgPicture.asset(
                                    'assets/icons/WorkoutIcons2.svg',
                                    width: 25,
                                    height: 25,
                                    color: Colors.black,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.more_horiz,
                                        color: Colors.black54),
                                    onPressed: () {},
                                  ),
                                ),
                                // Horizontally centered, vertically near bottom
                                Positioned(
                                  bottom: 15,
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "5",
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "SF-Pro-Display-Thin",
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Workouts",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "SF-Pro-Display-Thin",
                                          color: Colors.black54,
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
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),

      // floating button
      floatingActionButton: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(screenWidth * 0.035),
        color: const Color(0xFF9B2354),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: () => print("Floating button tapped"),
          child: Container(
            width: screenWidth * 0.155,
            height: screenWidth * 0.155,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/ActivitiesLogsIcons.svg',
              width: screenWidth * 0.06,
              height: screenWidth * 0.06,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
