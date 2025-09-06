import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

class SchedulePage extends StatefulWidget {
  final DateTime selectedDate;
  final Function(List<NeatCleanCalendarEvent>)?
      onEventsUpdated; // 👈 optional now

  const SchedulePage({
    super.key,
    required this.selectedDate,
    this.onEventsUpdated, // 👈 no longer required
  });

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final Map<DateTime, List<String>> _workoutSchedules = {};
  final Map<DateTime, List<String>> _mealSchedules = {};

  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      DateTime today = DateTime.now();
      _addWorkout(today, "Morning Run");
      _addMeal(today, "Breakfast - Oats & Eggs");

      DateTime anotherDay = DateTime(today.year, today.month, today.day + 2);
      _addWorkout(anotherDay, "Strength Training");
      _addMeal(anotherDay, "Lunch - Chicken & Rice");
    });
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

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
    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFECE6EF),
        elevation: 0,
        scrolledUnderElevation: 1,
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
          // Calendar
          Expanded(
            child: Calendar(
              startOnMonday: true,
              weekDays: const ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
              eventsList: _buildCalendarEvents(),
              showEvents: false,
              isExpandable: false,
              eventDoneColor: Colors.green,
              selectedColor: const Color(0xFF9B2354),
              todayColor: Colors.red,
              locale: 'en_US',
              todayButtonText: 'Today',
              isExpanded: false,
              expandableDateFormat: 'EEEE, dd. MMMM yyyy',
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = _normalizeDate(date);
                });
              },
            ),
          ),

          // Daily Schedule
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Schedule for ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9B2354)),
                  ),
                  const SizedBox(height: 10),

                  // Workouts
                  Expanded(
                    child: ListView(
                      children: [
                        const Text(
                          "Workouts",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        ...(_workoutSchedules[_selectedDate] ?? [])
                            .map((w) => ListTile(
                                  leading: const Icon(Icons.fitness_center,
                                      color: Color(0xFF9B2354)),
                                  title: Text(w),
                                )),

                        const SizedBox(height: 10),

                        // Meals
                        const Text(
                          "Meals",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        ...(_mealSchedules[_selectedDate] ?? [])
                            .map((m) => ListTile(
                                  leading: const Icon(Icons.restaurant,
                                      color: Color(0xFF9B2354)),
                                  title: Text(m),
                                )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Add buttons
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "addWorkout",
            backgroundColor: const Color(0xFF9B2354),
            child: const Icon(Icons.fitness_center),
            onPressed: () {
              _addWorkout(
                _selectedDate,
                "New Workout at ${DateTime.now().hour}:${DateTime.now().minute}",
              );
            },
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: "addMeal",
            backgroundColor: const Color(0xFF9B2354),
            child: const Icon(Icons.restaurant),
            onPressed: () {
              _addMeal(
                _selectedDate,
                "New Meal at ${DateTime.now().hour}:${DateTime.now().minute}",
              );
            },
          ),
        ],
      ),
    );
  }

  /// Convert workouts + meals into events for the calendar
  List<NeatCleanCalendarEvent> _buildCalendarEvents() {
    List<NeatCleanCalendarEvent> events = [];

    _workoutSchedules.forEach((date, workouts) {
      for (var w in workouts) {
        events.add(NeatCleanCalendarEvent(
          w,
          startTime: DateTime(date.year, date.month, date.day),
          endTime: DateTime(date.year, date.month, date.day, 23, 59),
          color: Colors.blue,
        ));
      }
    });

    _mealSchedules.forEach((date, meals) {
      for (var m in meals) {
        events.add(NeatCleanCalendarEvent(
          m,
          startTime: DateTime(date.year, date.month, date.day),
          endTime: DateTime(date.year, date.month, date.day, 23, 59),
          color: Colors.orange,
        ));
      }
    });

    return events;
  }
}
