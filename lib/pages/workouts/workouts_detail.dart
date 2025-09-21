import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:calisthenics_app/pages/workouts/workouts_start.dart';

class WorkoutDetailPage extends StatefulWidget {
  final String title;
  final String image;

  const WorkoutDetailPage({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  State<WorkoutDetailPage> createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  String _selectedDifficulty = "Beginner";

  // ✅ Added workout titles list
  final List<String> workoutTitles = [
    "Warm up with jumping jacks",
    "Push-ups",
    "Squats",
    "Plank",
    "Cool down stretches",
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFECE6EF),
      // AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // spacing from edges
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [],
        ),
        centerTitle: false,
      ),

      // Body
      body: Stack(
        children: [
          //workout image
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: Image.asset(
              widget.image,
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
                    elevation: 0,
                    color: const Color(0xFFECE6EF),
                    borderRadius: isFullScreen
                        ? BorderRadius.zero
                        : const BorderRadius.vertical(top: Radius.circular(25)),
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
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),

                            // Workout name
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontFamily: "SF-Pro-Display-Thin",
                              ),
                            ),
                            const SizedBox(height: 5),

                            // Description
                            const Text(
                              "A comprehensive full-body workout designed to improve strength, endurance, and flexibility. Perfect for all fitness levels.",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 5),

                            // Small info row (difficulty button, duration, calories burned)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Difficulty selector inside a Card
                                Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/GraphLvlIcon.svg",
                                          width: 12,
                                          height: 12,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(width: 5),
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: _selectedDifficulty,
                                            isDense: true,
                                            alignment: Alignment.centerLeft,
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              size: 14,
                                              color: Colors.black45,
                                            ),
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Colors.black87,
                                            ),
                                            items: const [
                                              DropdownMenuItem(
                                                  value: "Beginner",
                                                  child: Text("Beginner")),
                                              DropdownMenuItem(
                                                  value: "Easy",
                                                  child: Text("Easy")),
                                              DropdownMenuItem(
                                                  value: "Intermediate",
                                                  child: Text("Intermediate")),
                                              DropdownMenuItem(
                                                  value: "Advanced",
                                                  child: Text("Advanced")),
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedDifficulty = value!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 15),

                                // Duration
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
                                      "45 min",
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

                            const Divider(
                              thickness: 1,
                              color: Colors.black12,
                            ),

                            // WORKOUTS CARD
                            Column(
                              children: List.generate(5, (index) {
                                return SizedBox(
                                  width: screenWidth * 0.9,
                                  height: screenHeight * 0.13,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: Image.asset(
                                            "assets/images/workout1.jpg",
                                            width: screenWidth * 0.18,
                                            height: screenHeight * 0.09,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // ✅ Use workoutTitles
                                              Text(
                                                workoutTitles[index],
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              const SizedBox(height: 30),
                                              // Progress bar
                                              SizedBox(
                                                width: screenWidth * 0.55,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child:
                                                      const LinearProgressIndicator(
                                                    value: 0.4,
                                                    minHeight: 4.5,
                                                    backgroundColor:
                                                        Colors.black26,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Color(0xFF9B2354),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              const Text(
                                                "40% completed",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),

                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),

          // FLOATING ACTION BUTTON
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Material(
              elevation: 0.5,
              borderRadius: BorderRadius.circular(30),
              color: Colors.transparent,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Ink(
                decoration: BoxDecoration(
                  color: const Color(0xFF9B2354),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutStartPage(
                          title: widget.title,
                          videoUrl:
                              "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4",
                          description:
                              "A comprehensive full-body workout designed to improve strength, endurance, and flexibility. Perfect for all fitness levels.",
                          difficulty: "Intermediate",
                          duration: 300,
                          calories: 300,
                          steps: [
                            "Warm up with jumping jacks (1 min)",
                            "Push-ups (30 reps)",
                            "Squats (20 reps)",
                            "Plank (60 seconds)",
                            "Cool down stretches (2 mins)",
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: screenHeight * 0.05,
                    alignment: Alignment.center,
                    child: const Text(
                      "Start",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
