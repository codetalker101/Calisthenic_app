import 'package:flutter/material.dart';
import '../../pages/Profile/profile.dart';

class PlannersPage extends StatefulWidget {
  const PlannersPage({super.key});

  @override
  State<PlannersPage> createState() => _PlannersPageState();
}

class _PlannersPageState extends State<PlannersPage> {
  OverlayEntry? _overlayEntry;

  void _toggleMenu(BuildContext context) {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      return;
    }

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final fabOffset = renderBox.localToGlobal(Offset.zero);
    final fabSize = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: fabOffset.dx - 120 + fabSize.width / 2,
        bottom: MediaQuery.of(context).size.height -
            fabOffset.dy +
            fabSize.height +
            10,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        title: const Text(
          'Planners',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'AudioLinkMono',
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFECE6EF),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Nutrition Title
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 18, 18, 6),
              child: Text(
                "Nutrition Goals",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: "SF-Pro-Display-Thin",
                  color: Color(0xFF9B2354),
                ),
              ),
            ),

            /// Nutrition Goals Card (horizontal, smaller)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMacroColumn("Protein", 55, 125, Colors.redAccent),
                  _buildMacroColumn("Carbs", 200, 300, Colors.blueAccent),
                  _buildMacroColumn("Fat", 45, 70, Colors.orangeAccent),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 45,
        height: 45,
        child: FloatingActionButton(
          onPressed: () => _toggleMenu(context),
          backgroundColor: Color(0xFF9B2354),
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ),
    );
  }

  /// ---- Helper widget (horizontal style) ----
  Widget _buildMacroColumn(
      String label, int current, int goal, Color progressColor) {
    final double progress = current / goal;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 13)),
        const SizedBox(height: 6),
        SizedBox(
          width: 70,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text("$current/$goal g",
            style: const TextStyle(fontSize: 11, color: Colors.black54)),
      ],
    );
  }
}
