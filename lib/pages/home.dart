import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../pages/profile/profile.dart';

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
                  fontFamily: "SF-Pro-Display-Thin"),
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
                height: screenWidth * 0.25, //adjustable height
                width: screenHeight * 0.95, //adjustable width
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: const Offset(0, 1),
                    ),
                  ],
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
                              width: screenWidth * 0.12,
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
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: screenHeight * 0.20, //adjustable height
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                        width: screenWidth * 0.50,
                        margin: EdgeInsets.only(
                          left: index == 0 ? 14 : 4,
                          right: index == 3 ? 20 : 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/muscleUp.jpg'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
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
                              const Text(
                                'Strength Training',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                '60 mins',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11),
                              ),
                              const Spacer(),
                              LinearProgressIndicator(
                                value: 0.4,
                                backgroundColor: Colors.grey[600],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color(0xFF9B2354),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '40% Completed',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11),
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

            // Meals
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 20, 0),
                  child: Text(
                    'Planned Meals',
                    style: TextStyle(
                      color: Color(0xFF9B2354),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 20, 0),
                  child: Text(
                    '# ${DateFormat('EEEE').format(_focusedDate)}s Meals',
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
                SizedBox(height: 5),
                Column(
                  children: List.generate(4, (index) {
                    final meals = [
                      {
                        'type': 'Breakfast',
                        'name': 'Banana Toast with whey protein',
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

                    String mealName = meals[index]['name']!;
                    if (mealName.length > 25) {
                      mealName = '${mealName.substring(0, 25)}...';
                    }

                    return Container(
                      height: screenHeight * 0.13, //adjustable height
                      width: screenWidth * 0.95, //adjustable width
                      margin: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 5),
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
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                _getMealImage(meals[index]['type']!),
                                width: screenWidth * 0.22,
                                height: screenHeight * 0.22,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.02,
                                vertical: screenHeight * 0.011,
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
