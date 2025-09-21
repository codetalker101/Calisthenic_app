import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

class MacroNutrientsPage extends StatefulWidget {
  const MacroNutrientsPage({super.key});

  @override
  State<MacroNutrientsPage> createState() => _MacroNutrientsPageState();
}

class _MacroNutrientsPageState extends State<MacroNutrientsPage> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  DateTime _normalizeDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  // dummy events for calendar
  List<NeatCleanCalendarEvent> _buildCalendarEvents() {
    return [
      NeatCleanCalendarEvent(
        'Workout - Full Body',
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 1)),
        color: Colors.red,
      ),
      NeatCleanCalendarEvent(
        'Meal - Breakfast Oats',
        startTime: DateTime.now().add(const Duration(hours: 2)),
        endTime: DateTime.now().add(const Duration(hours: 3)),
        color: Colors.green,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dummy Data
    const int protein = 90;
    const int proteinGoal = 120;
    const int carbs = 180;
    const int carbsGoal = 250;
    const int fats = 60;
    const int fatsGoal = 80;

    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
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
      ),
      body: Column(
        children: [
          // 📅 Calendar Section
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45),
                bottomRight: Radius.circular(45),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Calendar(
              startOnMonday: true,
              weekDays: const ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
              eventsList: _buildCalendarEvents(),
              showEvents: false,
              isExpandable: false,
              showEventListViewIcon: false,
              eventDoneColor: Colors.green,
              selectedColor: const Color(0xFF9B2354),
              selectedTodayColor: const Color(0xFF9B2354),
              todayColor: const Color(0xFF9B2354),
              locale: 'en_US',
              todayButtonText: 'Today',
              isExpanded: false,
              expandableDateFormat: 'EEEE, dd. MMMM yyyy',
              initialDate: _selectedDate,
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = _normalizeDate(date);
                });
              },
            ),
          ),
          SizedBox(height: 10),
          // 📊 Macro Nutrients Section
          Container(
            margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
            width: double.infinity,
            child: Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(screenWidth * 0.06),
              color: Colors.transparent,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                height: screenHeight * 0.13,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.010,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.029),

                    // Nutrients Row
                    Expanded(
                      child: Row(
                        children: [
                          // Protein
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Protein",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.008),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: LinearProgressIndicator(
                                    value: protein / proteinGoal,
                                    minHeight: 6,
                                    backgroundColor: Colors.grey.shade300,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                      Color(0xFF9B2354),
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.008),
                                Text(
                                  "$protein/$proteinGoal g",
                                  style: const TextStyle(
                                    fontSize: 10.5,
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
                                const Text(
                                  "Carbs",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.008),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: LinearProgressIndicator(
                                    value: carbs / carbsGoal,
                                    minHeight: 6,
                                    backgroundColor: Colors.grey.shade300,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                      Colors.green,
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.008),
                                Text(
                                  "$carbs/$carbsGoal g",
                                  style: const TextStyle(
                                    fontSize: 10.5,
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
                                const Text(
                                  "Fat",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.008),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: LinearProgressIndicator(
                                    value: fats / fatsGoal,
                                    minHeight: 6,
                                    backgroundColor: Colors.grey.shade300,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                      Colors.orange,
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.008),
                                Text(
                                  "$fats/$fatsGoal g",
                                  style: const TextStyle(
                                    fontSize: 10.5,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 🍽 Meals Section
          Expanded(
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
                    // 🔹 Static Title
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

                    // 🔹 Scrollable Meal Cards
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          _buildMealCard("Egg Sandwich", "450 kcal", 20, 60, 10,
                              screenWidth, screenHeight),
                          _buildMealCard("Fried Chicken", "650 kcal", 30, 80,
                              20, screenWidth, screenHeight),
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
          ),
        ],
      ),
    );
  }

// 🔹 Meal Cards
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
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
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      "$protein g protein",
                      style:
                          const TextStyle(fontSize: 10, color: Colors.black54),
                    ),
                    SizedBox(width: 13),
                    Text(
                      "$carbs g carbs",
                      style:
                          const TextStyle(fontSize: 10, color: Colors.black54),
                    ),
                    SizedBox(width: 13),
                    Text(
                      "$fat g fats",
                      style:
                          const TextStyle(fontSize: 10, color: Colors.black54),
                    ),
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
}
