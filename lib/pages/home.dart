import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
// import 'package:flutter_svg/flutter_svg.dart';
import '../pages/Profile/profile.dart';

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

  double _appBarElevation = 0.0; // 👈 store AppBar shadow value

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

    // 👇 Add this: shadow appears when scrolled
    setState(() {
      _appBarElevation = position.pixels > 0 ? 4.0 : 0.0;
    });
  }

  // meals card background by it's type
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
                fontSize: 18,
                fontWeight: FontWeight.w800,
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
              child: Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  'assets/icons/saitama-profile-pic.png',
                  width: 36,
                  height: 36,
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
            // Compact Calender Container
            Material(
              elevation: 0, // keep ripple effect smooth
              borderRadius: BorderRadius.circular(25),
              color: Colors.transparent,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                height: 100,
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // soft black shadow
                      blurRadius: 10, // soften edges
                      spreadRadius: 0, // how much it spreads
                      offset: const Offset(0, 1), // vertical offset (downward)
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Month-Year Header
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

                    // Scrollable Dates Row
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
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
                                width: 50,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
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
                                        fontFamily: "SF-Pro-Display-Thin",
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
                                        fontFamily: "SF-Pro-Display-Thin",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Workout Chart Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Workout Chart Label
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'Planned Workouts',
                    style: TextStyle(
                      color: Color(0xFF9B2354),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: "SF-Pro-Display-Thin",
                    ),
                  ),
                ),
                const SizedBox(height: 0),

                // Date Sub Label
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    '# ${DateFormat('EEEE').format(_focusedDate)}s Workouts',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: "SF-Pro-Display-Thin",
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Horizontal Workout Cards
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Material(
                        elevation: 0, // soft elevation for shadow
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.transparent,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          width: 160,
                          margin: EdgeInsets.only(
                            left: index == 0 ? 14 : 4, //spacing between cards
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
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "SF-Pro-Display-Thin",
                                  ),
                                ),
                                const Text(
                                  '60 mins',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontFamily: "SF-Pro-Display-Thin",
                                  ),
                                ),
                                const Spacer(),
                                LinearProgressIndicator(
                                  value: 0.4,
                                  backgroundColor: Colors.grey[600],
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF9B2354),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  '40% Completed',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: "SF-Pro-Display-Thin",
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

            // Meal Planner Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(14, 10, 20, 0),
                  child: Text(
                    'Planned Meals',
                    style: TextStyle(
                      color: Color(0xFF9B2354),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "SF-Pro-Display-Thin",
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    '# ${DateFormat('EEEE').format(_focusedDate)}s Meals',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: "SF-Pro-Display-Thin",
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Directly build 4 cards (no vertical scroll)
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

                    // Truncate meal name if longer than 25 characters
                    String mealName = meals[index]['name']!;
                    if (mealName.length > 25) {
                      mealName = '${mealName.substring(0, 25)}...';
                    }

                    // meals planner card
                    return Material(
                      elevation: 0,
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.transparent,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                        height: 100,
                        width: 290,
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
                            // Left side → meal image with fixed padding
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Material(
                                borderRadius: BorderRadius.circular(25),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image.asset(
                                  _getMealImage(meals[index]['type']!),
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Right side → meal details
                            Expanded(
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  // Calculate padding values
                                  double topPadding =
                                      constraints.maxHeight * 0.12;
                                  double bottomPadding =
                                      constraints.maxHeight * 0;
                                  double leftPadding =
                                      constraints.maxWidth * 0.04;
                                  double rightPadding =
                                      constraints.maxWidth * 0.04;

                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(
                                      leftPadding,
                                      topPadding,
                                      rightPadding,
                                      bottomPadding,
                                    ),
                                    child: SizedBox(
                                      height: constraints.maxHeight -
                                          (topPadding + bottomPadding),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              mealName, // Use the truncated name
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // Updated this part to include protein
                                                Row(
                                                  children: [
                                                    Text(
                                                      meals[index]['calories']!,
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      '${meals[index]['protein']} protein',
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10,
                                                      ),
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
                                                  constraints:
                                                      const BoxConstraints(),
                                                  onPressed: () {},
                                                ),
                                              ],
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
                    );
                  }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
