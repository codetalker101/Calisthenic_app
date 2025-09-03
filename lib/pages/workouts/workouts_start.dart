import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class WorkoutStartPage extends StatefulWidget {
  final String title;
  final String videoUrl;
  final String description;
  final String difficulty;
  final int duration; // total workout duration in seconds (excluding rests)
  final int calories;
  final List<String> steps;

  const WorkoutStartPage({
    super.key,
    required this.title,
    required this.videoUrl,
    required this.description,
    required this.difficulty,
    required this.duration,
    required this.calories,
    required this.steps,
  });

  @override
  State<WorkoutStartPage> createState() => _WorkoutStartPageState();
}

class _WorkoutStartPageState extends State<WorkoutStartPage> {
  // VIDEO PLAYER (WORKOUTS VIDEO)
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;

  // WORKOUTS TIMER
  Timer? _timer;
  int _remainingTime = 0;
  bool _isRunning = false;

  // AUDIO SOUND (WORKOUT BEEP)
  late AudioPlayer _audioPlayer;

  Future<void> _playStartFinishedBeep() async {
    await _audioPlayer.play(AssetSource('sounds/notifSound(whistle2).mp3'));
  }

  Future<void> _playCardTransitionBeep() async {
    await _audioPlayer.play(AssetSource('sounds/notifSound(whistle1).mp3'));
  }

  List<Map<String, dynamic>> _allCards = []; // ✅ initialize with empty list

  @override
  void initState() {
    super.initState();

    _audioPlayer = AudioPlayer();

    // distribute duration evenly across steps
    int stepDuration = widget.steps.isNotEmpty
        ? (widget.duration / widget.steps.length).floor()
        : 0;

    _allCards = [];
    for (int i = 0; i < widget.steps.length; i++) {
      _allCards.add({
        "title": widget.steps[i],
        "type": "workout",
        "duration": stepDuration,
      });
      if (i < widget.steps.length - 1) {
        _allCards.add({
          "title": "Rest",
          "type": "rest",
          "duration": 60, // 1 minute
        });
      }
    }

    _remainingTime =
        _allCards.fold(0, (sum, item) => sum + (item["duration"] as int));

    _videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _videoController.initialize().then((_) {
      setState(() {});
    });

    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: false,
      looping: false,
      allowFullScreen: true,
      allowMuting: true,
    );
  }

  void _startTimer() {
    if (_isRunning) return;
    setState(() => _isRunning = true);

    // 🔊 Play start beep
    _playStartFinishedBeep();

    int elapsed = _elapsedTime(); // already completed time

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
          elapsed++;

          // 🔔 Check if a card just finished
          int timeCounter = 0;
          for (int i = 0; i < _allCards.length; i++) {
            int d = _allCards[i]["duration"];
            timeCounter += d;
            if (elapsed == timeCounter) {
              _playCardTransitionBeep(); // 🔊 Play card transition beep
            }
          }
        });
      } else {
        timer.cancel();
        setState(() => _isRunning = false);

        // 🔊 Play finish beep
        _playStartFinishedBeep();
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final min = seconds ~/ 60;
    final sec = seconds % 60;
    return "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }

  double _progress() {
    final totalTime =
        _allCards.fold(0, (sum, item) => sum + (item["duration"] as int));
    if (totalTime == 0) return 0;
    return 1 - (_remainingTime / totalTime);
  }

  int _elapsedTime() {
    final totalTime =
        _allCards.fold(0, (sum, item) => sum + (item["duration"] as int));
    return totalTime - _remainingTime;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final elapsed = _elapsedTime();

    // figure out current card index and per-card progress
    int timeCounter = 0;
    int currentIndex = 0;
    double cardProgress = 0;

    for (int i = 0; i < _allCards.length; i++) {
      int d = _allCards[i]["duration"];
      if (elapsed < timeCounter + d) {
        currentIndex = i;
        if (elapsed < timeCounter + d) {
          currentIndex = i;
          cardProgress = d > 0 ? (elapsed - timeCounter) / d : 0;
          break;
        }
        break;
      }
      timeCounter += d;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
        leading: IconButton(
          enableFeedback: false, // no click sound
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.title, style: const TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Video Player
            AspectRatio(
              aspectRatio: 16 / 9,
              child: _chewieController != null &&
                      _chewieController!
                          .videoPlayerController.value.isInitialized
                  ? Chewie(controller: _chewieController!)
                  : const Center(child: CircularProgressIndicator()),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.description,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black87)),
                  const SizedBox(height: 10),

                  // Info row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _infoChip("assets/icons/clockIcon.svg",
                          "${widget.duration ~/ 60} min"),
                      const SizedBox(width: 15),
                      _infoChip(
                          "assets/icons/GraphLvlIcon.svg", widget.difficulty),
                      const SizedBox(width: 15),
                      _infoChip("assets/icons/CaloriesBurntIcon.svg",
                          "${widget.calories} cal"),
                    ],
                  ),
                  const Divider(height: 20, color: Colors.black26),

                  // Timer display
                  Center(
                    child: Text(
                      _formatTime(_remainingTime),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Global progress bar
                  LinearProgressIndicator(
                    value: _progress(),
                    minHeight: 10,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF9B2354)),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "${(_progress() * 100).toStringAsFixed(0)}% completed",
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Start/Pause button
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9B2354),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: _isRunning ? _pauseTimer : _startTimer,
                      child: Text(
                        _isRunning ? "Pause" : "Start",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    "Workout Steps",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 10),

                  // Steps + Rest cards
                  Column(
                    children: List.generate(_allCards.length, (index) {
                      final card = _allCards[index];
                      final isCompleted = index < currentIndex;
                      final isCurrent = index == currentIndex;

                      return Card(
                        color: card["type"] == "rest"
                            ? Colors.blue[50]
                            : Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    isCompleted
                                        ? Icons.check_circle
                                        : isCurrent
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_unchecked,
                                    color: isCompleted
                                        ? Colors.green
                                        : isCurrent
                                            ? const Color(0xFF9B2354)
                                            : Colors.grey,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      card["title"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: isCurrent
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: isCompleted
                                            ? Colors.green
                                            : isCurrent
                                                ? Colors.black
                                                : Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${(card["duration"] / 60).toStringAsFixed(1)} min",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: isCompleted
                                    ? 1
                                    : isCurrent
                                        ? cardProgress
                                        : 0,
                                minHeight: 6,
                                backgroundColor: Colors.grey[300],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  isCompleted
                                      ? Colors.green
                                      : isCurrent
                                          ? const Color(0xFF9B2354)
                                          : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: screenHeight * 0.1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(String svgPath, String text) {
    return Row(
      children: [
        SvgPicture.asset(
          svgPath,
          width: 12,
          height: 12,
          colorFilter: const ColorFilter.mode(
            Colors.black54,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}
