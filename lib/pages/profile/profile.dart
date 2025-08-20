import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              'My Profile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'AudioLinkMono',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ✅ Profile icon + name
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black12,
                    child: Icon(
                      Icons.person,
                      size: 35,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Chanyu",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Workout-style profile card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: Colors.black.withOpacity(0.15),
                  width: 1,
                ),
              ),
              child: Column(
                children: const [
                  _ProfileRow(title: "Height", value: "190 cm"),
                  Divider(height: 1, color: Colors.black26),
                  _ProfileRow(title: "Weight", value: "88 kg"),
                  Divider(height: 1, color: Colors.black26),
                  _ProfileRow(title: "Protein/day", value: "220 g"),
                  Divider(height: 1, color: Colors.black26),
                  _ProfileRow(title: "Calories/day", value: "3500 kcal"),
                  Divider(height: 1, color: Colors.black26),
                  _ProfileRow(title: "BMI", value: "22.9 (Normal)"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Reusable row widget
class _ProfileRow extends StatelessWidget {
  final String title;
  final String value;

  const _ProfileRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
