import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MealDetailPage extends StatefulWidget {
  const MealDetailPage({super.key});

  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  // track selected tab: 0 = Ingredients, 1 = Instructions
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    // Dummy data
    const String imageUrl = "assets/images/foodImgEx.jpg";
    const String foodName = "Creamy Alfredo Pasta";
    const String description =
        "A rich and creamy Alfredo pasta topped with parmesan and parsley. "
        "Perfect for dinner nights. soooooo fucking delicious";

    // dummy data for ingredients & instructions
    final ingredients = [
      "200g pasta",
      "1 cup heavy cream",
      "1/2 cup parmesan cheese",
      "2 tbsp butter",
      "Parsley, salt & pepper",
    ];
    final instructions = [
      "1. Boil pasta until al dente.",
      "2. In a pan, melt butter & add cream.",
      "3. Stir in parmesan until smooth.",
      "4. Add pasta & toss well.",
      "5. Garnish with parsley, serve hot!",
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // spacing from edges
          child: CircleAvatar(
            backgroundColor: const Color(0xFFECE6EF), // 👈 circle color
            child: IconButton(
              enableFeedback: false, // no click sound
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black, // 👈 arrow color
              ),
              onPressed: () {
                Navigator.pop(context); // go back
              },
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [],
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          // Top half food image
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: Image.asset(
              imageUrl,
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
                    elevation: 1, // gives shadow
                    color: const Color(0xFFECE6EF),
                    borderRadius: isFullScreen
                        ? BorderRadius.zero
                        : const BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                    clipBehavior:
                        Clip.antiAlias, // ensures rounded corners clip
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

                            // Food name
                            Text(
                              foodName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontFamily: "SF-Pro-Display-Thin",
                              ),
                            ),
                            const SizedBox(height: 5),

                            // Description
                            Text(
                              description,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Small info row (time, difficulty, calories)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Time
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/clockIcon.svg",
                                      width: 12,
                                      height: 12,
                                      color: Colors.black45,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      "10 minutes",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 15),

                                // Difficulty
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/GraphLvlIcon.svg",
                                      width: 12,
                                      height: 12,
                                      color: Colors.black45,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      "medium",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 15),

                                // Calories
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/CaloriesBurntIcon.svg",
                                      width: 12,
                                      height: 12,
                                      color: Colors.black45,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      "300 cal",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 0),

                            // Divider line beneath info row
                            const Divider(
                              thickness: 1,
                              color: Colors.black12,
                            ),

                            const SizedBox(height: 0),

                            // Toggle text buttons wrapped in ONE Card
                            Center(
                              child: SizedBox(
                                width: 199, // ⬅️ keep width
                                height: 30, // ⬅️ keep height
                                child: Material(
                                  elevation: 1,
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Stack(
                                    children: [
                                      // Background fill for selected half (FADE instead of SLIDE)
                                      AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        transitionBuilder: (child, animation) =>
                                            FadeTransition(
                                                opacity: animation,
                                                child: child),
                                        child: Align(
                                          key: ValueKey<int>(selectedTab),
                                          alignment: selectedTab == 0
                                              ? Alignment.centerLeft
                                              : Alignment.centerRight,
                                          child: Container(
                                            width: 199 / 2,
                                            height: 33,
                                            color: const Color(0xFF9B2354),
                                          ),
                                        ),
                                      ),

                                      // Foreground row with divider + buttons
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

                                          // VERTICAL DIVIDER
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
                            const SizedBox(height: 20),

                            // AnimatedSwitcher for Ingredients / Instructions content
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              transitionBuilder: (child, animation) =>
                                  FadeTransition(
                                      opacity: animation, child: child),
                              child: SizedBox(
                                key: ValueKey<int>(selectedTab),
                                width: double.infinity,
                                child: selectedTab == 0
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Ingredients",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          for (var item in ingredients)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 6),
                                              child: Text(
                                                "• $item",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Instructions",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          for (var step in instructions)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 6),
                                              child: Text(
                                                step,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
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
