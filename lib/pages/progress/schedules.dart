import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:calisthenics_app/pages/meals/meals_details.dart';
import 'package:calisthenics_app/pages/workouts/workouts_detail.dart';

class SchedulePage extends StatefulWidget {
  final DateTime selectedDate;
  final Function(List<NeatCleanCalendarEvent>)? onEventsUpdated;

  const SchedulePage({
    super.key,
    required this.selectedDate,
    this.onEventsUpdated,
  });

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  // meals card background by its type (dummy background pictures)
  String _getMealImage(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return 'assets/images/breakfast.jpg';
      case 'lunch':
        return 'assets/images/lunch.jpg';
      case 'snack':
        return 'assets/images/snacks.jpg';
      case 'dinner':
        return 'assets/images/dinner.jpg';
      default:
        return 'assets/images/default-meal.jpg';
    }
  }

  // workout dummy images
  String _getWorkoutImage(String workoutTitle) {
    if (workoutTitle.toLowerCase().contains("full body")) {
      return "assets/images/workout1.jpg";
    } else if (workoutTitle.toLowerCase().contains("upper")) {
      return "assets/images/workout2.jpg";
    } else if (workoutTitle.toLowerCase().contains("lower")) {
      return "assets/images/workout3.jpg";
    } else if (workoutTitle.toLowerCase().contains("push")) {
      return "assets/images/workout4.jpg";
    } else if (workoutTitle.toLowerCase().contains("pull")) {
      return "assets/images/workout2.jpg";
    }
    return "assets/images/workout1.jpg";
  }

  final List<Map<String, String>> meals = [
    {
      'type': 'Breakfast',
      'name': 'Banana Toast with whey protein, and melted cheese',
      'calories': '450 kcal',
      'protein': '55g',
    },
    {
      'type': 'Lunch',
      'name': 'Grilled Chicken',
      'calories': '600 kcal',
      'protein': '55g',
    },
    {
      'type': 'Snack',
      'name': 'L-men Protein Bar',
      'calories': '250 kcal',
      'protein': '55g',
    },
    {
      'type': 'Dinner',
      'name': 'Salmon Bowl',
      'calories': '550 kcal',
      'protein': '55g',
    },
  ];

  bool _isMenuOpen = false; // for floating button

  final Map<DateTime, List<String>> _workoutSchedules = {};
  final Map<DateTime, List<String>> _mealSchedules = {};

  late DateTime _selectedDate;
  int _selectedToggle = 0; // 0 = Workouts, 1 = Meals

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      DateTime today = DateTime.now();
      _addWorkout(today, "Full Body Training");
      _addMeal(today, "Breakfast - Oats & Eggs");

      DateTime anotherDay = DateTime(today.year, today.month, today.day + 2);
      _addWorkout(anotherDay, "Strength Training");
      _addMeal(anotherDay, "Lunch - Chicken & Rice");
    });
  }

  DateTime _normalizeDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  void _addWorkout(DateTime date, String workout) {
    final normalizedDate = _normalizeDate(date);
    setState(() {
      _workoutSchedules.putIfAbsent(normalizedDate, () => []).add(workout);
    });
    widget.onEventsUpdated?.call(_buildCalendarEvents());
  }

  void _addMeal(DateTime date, String meal) {
    final normalizedDate = _normalizeDate(date);
    setState(() {
      _mealSchedules.putIfAbsent(normalizedDate, () => []).add(meal);
    });
    widget.onEventsUpdated?.call(_buildCalendarEvents());
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFECE6EF), // page background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Schedules',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'AudioLinkMono',
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
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
          const SizedBox(height: 10),
          // Custom Toggle Button
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: Center(
              child: SizedBox(
                width: 300,
                height: 30,
                child: Material(
                  elevation: 0.5,
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    children: [
                      // Background fade effect
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder: (child, animation) => FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                        child: Row(
                          key: ValueKey<int>(_selectedToggle),
                          children: [
                            if (_selectedToggle == 0)
                              Container(
                                width: 300 / 2,
                                height: 33,
                                color: const Color(0xFF9B2354),
                              )
                            else
                              const SizedBox(width: 300 / 2),
                            if (_selectedToggle == 1)
                              Container(
                                width: 300 / 2,
                                height: 33,
                                color: const Color(0xFF9B2354),
                              ),
                          ],
                        ),
                      ),

                      // Foreground buttons
                      Row(
                        children: [
                          // Workouts
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() => _selectedToggle = 0);
                              },
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/PlannerIcon1.svg",
                                      width: 14,
                                      height: 14,
                                      color: _selectedToggle == 0
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Workouts schedule",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: _selectedToggle == 0
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: _selectedToggle == 0
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Divider
                          Container(
                            width: 1,
                            height: 20,
                            color: Colors.black26,
                          ),

                          // Meals
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() => _selectedToggle = 1);
                              },
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/mealSchedules.svg",
                                      width: 14,
                                      height: 14,
                                      color: _selectedToggle == 1
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Meals schedule",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: _selectedToggle == 1
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: _selectedToggle == 1
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
          ),

          // Daily Schedule (toggle controlled)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xECE6EF), // background color
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30), // rounded top-left
                          topRight: Radius.circular(30), // rounded top-right
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Static title depending on toggle
                          if (_selectedToggle == 0)
                            Container(
                              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                              child: const Text(
                                "Workouts",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF9B2354),
                                  fontFamily: "SF-Pro-Display-Thin",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          if (_selectedToggle == 0) const SizedBox(height: 8),

                          if (_selectedToggle == 1)
                            Container(
                              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                              child: const Text(
                                "Meals",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF9B2354),
                                  fontFamily: "SF-Pro-Display-Thin",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          if (_selectedToggle == 1) const SizedBox(height: 8),

                          // Scrollable list of items
                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: _selectedToggle == 0
                                  ? [
                                      ...(_workoutSchedules[_selectedDate] ??
                                              [])
                                          .map((w) {
                                        double progress = 0.2; // dummy progress
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .push(
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    WorkoutDetailPage(
                                                  title: w,
                                                  image: _getWorkoutImage(w),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: screenHeight * 0.13,
                                            width: double.infinity,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.asset(
                                                      _getWorkoutImage(w),
                                                      width: screenWidth * 0.23,
                                                      height:
                                                          screenHeight * 0.16,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal:
                                                          screenWidth * 0.02,
                                                      vertical:
                                                          screenHeight * 0.015,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              w,
                                                              style:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xFF9B2354),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            const SizedBox(
                                                                height: 1),
                                                            const Text(
                                                              "45 min workout",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 11,
                                                                fontFamily:
                                                                    "SF-Pro-Display-Thin",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 230,
                                                              child:
                                                                  LinearProgressIndicator(
                                                                value: progress,
                                                                backgroundColor:
                                                                    Colors.grey
                                                                        .shade300,
                                                                color: const Color(
                                                                    0xFF9B2354),
                                                                minHeight: 4,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Text(
                                                              "${(progress * 100).toStringAsFixed(0)}% completed",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 11,
                                                                fontFamily:
                                                                    "SF-Pro-Display-Thin",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ]
                                  : [
                                      // Scrollable Meals list
                                      ...meals.map((meal) {
                                        String mealName = meal['name']!;
                                        if (mealName.length > 42) {
                                          mealName =
                                              '${mealName.substring(0, 42)}...';
                                        }

                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .push(
                                              MaterialPageRoute(
                                                builder: (_) => MealDetailPage(
                                                  imageUrl: _getMealImage(
                                                      meal['type']!),
                                                  foodName: meal['name']!,
                                                  description:
                                                      "A tasty ${meal['type']} option packed with protein.",
                                                  calories: meal['calories']!,
                                                  protein: meal['protein']!,
                                                  time: "10 minutes",
                                                  difficulty: "Medium",
                                                  ingredients: [
                                                    "200g chicken breast",
                                                    "1 tbsp olive oil",
                                                    "Salt & pepper",
                                                    "Mixed vegetables",
                                                  ],
                                                  instructions: [
                                                    "1. Season chicken with salt & pepper.",
                                                    "2. Heat pan with olive oil.",
                                                    "3. Cook chicken until golden brown.",
                                                    "4. Add vegetables & stir fry.",
                                                    "5. Serve warm.",
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: screenHeight * 0.13,
                                            width: screenWidth * 0.95,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Image.asset(
                                                      _getMealImage(
                                                          meal['type']!),
                                                      width: screenWidth * 0.22,
                                                      height:
                                                          screenHeight * 0.22,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      vertical:
                                                          screenHeight * 0.013,
                                                      horizontal:
                                                          screenWidth * 0.02,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          meal['type']!,
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF9B2354),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            mealName,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  meal[
                                                                      'calories']!,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Text(
                                                                  '${meal['protein']} protein',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                              ],
                                                            ),
                                                            IconButton(
                                                              enableFeedback:
                                                                  false,
                                                              icon: const Icon(
                                                                  Icons
                                                                      .more_vert,
                                                                  color: Color(
                                                                      0xFF9B2354),
                                                                  size: 20),
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              constraints:
                                                                  const BoxConstraints(),
                                                              onPressed: () {},
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Floating button with smooth fade + slide effect
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        children: [
          // Workout button
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _isMenuOpen ? 1 : 0,
            child: AnimatedSlide(
              offset: _isMenuOpen ? const Offset(0, 0) : const Offset(0, 0.5),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 130.0, right: 1.0),
                child: FloatingActionButton.extended(
                  heroTag: "addWorkout",
                  backgroundColor: const Color(0xFF9B2354),
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.fitness_center),
                  label: const Text("Add Workout"),
                  onPressed: () {
                    setState(() => _isMenuOpen = false);
                    _addWorkout(
                      _selectedDate,
                      "New Workout at ${DateTime.now().hour}:${DateTime.now().minute}",
                    );
                  },
                ),
              ),
            ),
          ),

          // Meal button
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _isMenuOpen ? 1 : 0,
            child: AnimatedSlide(
              offset: _isMenuOpen ? const Offset(0, 0) : const Offset(0, 0.5),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 65.0, right: 1.0),
                child: FloatingActionButton.extended(
                  heroTag: "addMeal",
                  backgroundColor: const Color(0xFF9B2354),
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.restaurant),
                  label: const Text("Add Meal"),
                  onPressed: () {
                    setState(() => _isMenuOpen = false);
                    _addMeal(
                      _selectedDate,
                      "New Meal at ${DateTime.now().hour}:${DateTime.now().minute}",
                    );
                  },
                ),
              ),
            ),
          ),

          // Main FAB (+)
          FloatingActionButton(
            heroTag: "mainFAB",
            backgroundColor: const Color(0xFF9B2354),
            foregroundColor: Colors.white,
            elevation: 0,
            child: Icon(_isMenuOpen ? Icons.close : Icons.add),
            onPressed: () {
              setState(() {
                _isMenuOpen = !_isMenuOpen;
              });
            },
          ),
        ],
      ),
    );
  }

  // Convert workouts + meals into events for the calendar
  List<NeatCleanCalendarEvent> _buildCalendarEvents() {
    List<NeatCleanCalendarEvent> events = [];

    _workoutSchedules.forEach(
      (date, workouts) {
        for (var w in workouts) {
          events.add(
            NeatCleanCalendarEvent(
              w,
              startTime: DateTime(date.year, date.month, date.day),
              endTime: DateTime(date.year, date.month, date.day, 23, 59),
              color: Colors.blue,
            ),
          );
        }
      },
    );

    _mealSchedules.forEach(
      (date, meals) {
        for (var m in meals) {
          events.add(
            NeatCleanCalendarEvent(
              m,
              startTime: DateTime(date.year, date.month, date.day),
              endTime: DateTime(date.year, date.month, date.day, 23, 59),
              color: Colors.orange,
            ),
          );
        }
      },
    );

    return events;
  }
}
