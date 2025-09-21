import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:calisthenics_app/pages/profile/profile.dart';
import 'package:calisthenics_app/pages/workouts/workouts_detail.dart';
import 'package:calisthenics_app/pages/meals/meals_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();
  Timer? _dateCheckTimer;

  static const List<Map<String, String>> workouts = [
    {
      'title': 'Full Body Training',
      'image': 'assets/images/workout1.jpg',
    },
    {
      'title': 'Upper Body Training',
      'image': 'assets/images/workout2.jpg',
    },
    {
      'title': 'Lower Body Training',
      'image': 'assets/images/workout3.jpg',
    },
    {
      'title': 'Push Training',
      'image': 'assets/images/workout4.jpg',
    },
  ];

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

  double _appBarElevation = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    _dateCheckTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      final now = DateTime.now();
      if (_focusedDate.day != now.day ||
          _focusedDate.month != now.month ||
          _focusedDate.year != now.year) {
        setState(() {
          _selectedDate = now;
          _focusedDate = now;
        });
      }
    });
  }

  void _handleScroll() {
    final position = _scrollController.position;
    final days = position.pixels ~/ 54;
    final newDate = DateTime.now().add(Duration(days: days));

    if (newDate.month != _focusedDate.month) {
      setState(() {
        _focusedDate = newDate;
      });
    }

    setState(() {
      _appBarElevation = position.pixels > 0 ? 4.0 : 0.0;
    });
  }

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

  @override
  void dispose() {
    _dateCheckTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        scrolledUnderElevation: 1,
        backgroundColor: const Color(0xFFECE6EF),
        elevation: _appBarElevation,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'CalistherPAL',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'AudioLinkMono',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Welcome back, Malik 👋',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontFamily: "SF-Pro-Display-Thin",
              ),
            ),
          ],
        ),
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
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Compact Calendar
            Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(25),
              color: Colors.transparent,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                height: screenHeight * 0.13, //adjustable height
                width: screenWidth * 0.95, //adjustable width
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 8),
                      child: Text(
                        DateFormat('MMMM yyyy').format(_focusedDate),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "SF-Pro-Display-Thin",
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: 365,
                        itemBuilder: (context, index) {
                          final date =
                              DateTime.now().add(Duration(days: index));
                          final isSelected = _selectedDate.day == date.day &&
                              _selectedDate.month == date.month &&
                              _selectedDate.year == date.year;

                          return GestureDetector(
                            onTap: () => setState(() {
                              _selectedDate = date;
                              _focusedDate = date;
                            }),
                            child: Container(
                              width: screenWidth * 0.115,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF9B2354)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormat('E').format(date)[0],
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black54,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    date.day.toString(),
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Workouts
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Planned Workouts',
                    style: TextStyle(
                      color: Color(0xFF9B2354),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    '# ${DateFormat('EEEE').format(_focusedDate)}s Workouts',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: screenHeight * 0.20, // adjustable height
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: workouts.length,
                    itemBuilder: (context, index) {
                      final workout = workouts[index];
                      final progress = (index + 1) * 0.2; // dummy % completed

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (_) => WorkoutDetailPage(
                                title: workout['title']!,
                                image: workout['image']!,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: screenWidth * 0.50,
                          margin: EdgeInsets.only(
                            left: index == 0 ? 14 : 4,
                            right: index == workouts.length - 1 ? 20 : 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: AssetImage(workout['image']!),
                              fit: BoxFit.cover,
                              colorFilter: const ColorFilter.mode(
                                Colors.black54,
                                BlendMode.darken,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  workout['title']!, // dynamic title
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  '45 mins', // fixed duration
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                                const Spacer(),
                                LinearProgressIndicator(
                                  value: progress,
                                  backgroundColor: Colors.grey[600],
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF9B2354),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${(progress * 100).toInt()}% Completed',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            // Meals
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Planned Meals',
                    style: TextStyle(
                      color: Color(0xFF9B2354),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    '# ${DateFormat('EEEE').format(_focusedDate)}s Meals',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Meal Cards
                Column(
                  children: List.generate(meals.length, (index) {
                    String mealName = meals[index]['name']!;
                    if (mealName.length > 42) {
                      mealName = '${mealName.substring(0, 42)}...';
                    }
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (_) => MealDetailPage(
                              imageUrl: _getMealImage(meals[index]['type']!),
                              foodName: meals[index]['name']!,
                              description:
                                  "A tasty ${meals[index]['type']} option packed with protein.",
                              calories: meals[index]['calories']!,
                              protein: meals[index]['protein']!,
                              time:
                                  "10 minutes", // you can add this to meals[] too
                              difficulty: "Medium", // also can be dynamic
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
                            horizontal: 14, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  _getMealImage(meals[index]['type']!),
                                  width: screenWidth * 0.22,
                                  height: screenWidth * 0.22,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.02,
                                  vertical: screenWidth * 0.03,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      meals[index]['type']!,
                                      style: const TextStyle(
                                        color: Color(0xFF9B2354),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        mealName,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              meals[index]['calories']!,
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              '${meals[index]['protein']} protein',
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          enableFeedback: false,
                                          icon: const Icon(
                                            Icons.more_vert,
                                            color: Color(0xFF9B2354),
                                            size: 20,
                                          ),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
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
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
