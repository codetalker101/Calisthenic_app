import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MealDetailPage extends StatefulWidget {
  final String imageUrl;
  final String foodName;
  final String description;
  final String calories;
  final String protein;
  final String time;
  final String difficulty;
  final List<String> ingredients;
  final List<String> instructions;

  const MealDetailPage({
    super.key,
    required this.imageUrl,
    required this.foodName,
    required this.description,
    required this.calories,
    required this.protein,
    required this.time,
    required this.difficulty,
    required this.ingredients,
    required this.instructions,
  });

  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  // track selected tab: 0 = Ingredients, 1 = Instructions
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFECE6EF),
            child: IconButton(
              enableFeedback: false,
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Top half food image
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: Image.asset(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),

          // Slidable content
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.55,
            maxChildSize: 1.0,
            builder: (context, scrollController) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final isFullScreen = constraints.maxHeight ==
                      MediaQuery.of(context).size.height;

                  return Material(
                    elevation: 1,
                    color: const Color(0xFFECE6EF),
                    borderRadius: isFullScreen
                        ? BorderRadius.zero
                        : const BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Handle strip
                            Center(
                              child: Container(
                                width: 90,
                                height: 3,
                                margin: const EdgeInsets.only(bottom: 15),
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),

                            // Dynamic Food name
                            Text(
                              widget.foodName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontFamily: "SF-Pro-Display-Thin",
                              ),
                            ),
                            const SizedBox(height: 5),

                            // Dynamic Description
                            Text(
                              widget.description,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Info row (time, difficulty, calories)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/clockIcon.svg",
                                      width: 12,
                                      height: 12,
                                      color: Colors.black45,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      widget.time,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 15),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/GraphLvlIcon.svg",
                                      width: 12,
                                      height: 12,
                                      color: Colors.black45,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      widget.difficulty,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 15),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/CaloriesBurntIcon.svg",
                                      width: 12,
                                      height: 12,
                                      color: Colors.black45,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      widget.calories,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const Divider(
                              thickness: 1,
                              color: Colors.black12,
                            ),
                            const SizedBox(height: 5),

                            // Toggle text buttons
                            Center(
                              child: SizedBox(
                                width: 210,
                                height: 30,
                                child: Material(
                                  elevation: 1,
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Stack(
                                    children: [
                                      // Background fill for selected half (FADE)
                                      AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        transitionBuilder: (child, animation) =>
                                            FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        ),
                                        child: Align(
                                          key: ValueKey<int>(selectedTab),
                                          alignment: selectedTab == 0
                                              ? Alignment.centerLeft
                                              : Alignment.centerRight,
                                          child: Container(
                                            width: 210 / 2,
                                            height: 33,
                                            color: const Color(0xFF9B2354),
                                          ),
                                        ),
                                      ),

                                      // Foreground row with buttons
                                      Row(
                                        children: [
                                          // LEFT TAB
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedTab = 0;
                                                });
                                              },
                                              child: Center(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/todolistIcons.svg",
                                                      width: 14,
                                                      height: 14,
                                                      color: selectedTab == 0
                                                          ? Colors.white
                                                          : Colors.black87,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      "Ingredients",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            selectedTab == 0
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal,
                                                        color: selectedTab == 0
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

                                          // RIGHT TAB
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedTab = 1;
                                                });
                                              },
                                              child: Center(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/cookingInstruction.svg",
                                                      width: 14,
                                                      height: 14,
                                                      color: selectedTab == 1
                                                          ? Colors.white
                                                          : Colors.black87,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      "Instructions",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            selectedTab == 1
                                                                ? FontWeight
                                                                    .bold
                                                                : FontWeight
                                                                    .normal,
                                                        color: selectedTab == 1
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
                            const SizedBox(height: 10),

                            // Ingredients / Instructions inside adjustable Card
                            AnimatedCrossFade(
                              duration: const Duration(milliseconds: 250),
                              crossFadeState: selectedTab == 0
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              // Ingredients card
                              firstChild: Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 6,
                                ),
                                elevation: 0,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 12,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Ingredients",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: Colors.black26,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: widget.ingredients
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          final i = entry.key;
                                          final item = entry.value;
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "• $item",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              if (i !=
                                                  widget.ingredients.length - 1)
                                                const Divider(
                                                  thickness: 1,
                                                  color: Colors.black12,
                                                ),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Instructions card
                              secondChild: Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 6),
                                elevation: 0,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 12,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Instructions",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Divider(
                                          thickness: 1, color: Colors.black26),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: widget.instructions
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          final i = entry.key;
                                          final step = entry.value;
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                step,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              if (i !=
                                                  widget.instructions.length -
                                                      1)
                                                const Divider(
                                                  thickness: 1,
                                                  color: Colors.black12,
                                                ),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
