import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double height = 179; // cm
  double weight = 64; // kg

  // Protein/day recommendation = 2.5 g per kg
  double get protein => weight * 2.5;

  // Calories/day estimation (simple: 40 kcal per kg)
  double get calories => weight * 40;

  // BMI calculation
  double get bmi => weight / ((height / 100) * (height / 100));

  String get bmiCategory {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 24.9) return "Normal";
    if (bmi < 29.9) return "Overweight";
    return "Obese";
  }

  /// 🔹 Value Editor Dialog
  void _editValue(String title, double currentValue, Function(double) onSave) {
    final controller =
        TextEditingController(text: currentValue.toStringAsFixed(1));

    showDialog(
      context: context,
      builder: (ctx) => Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFF9B2354),
            selectionColor: Color(0xFF9B2354),
            selectionHandleColor: Color(0xFFECE6EF),
          ),
        ),
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Edit $title",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xFF9B2354), width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.black26, width: 1),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "Enter $title",
              hintStyle: const TextStyle(color: Colors.black45),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child:
                  const Text("Cancel", style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9B2354),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final newValue = double.tryParse(controller.text);
                if (newValue != null && newValue > 0) {
                  onSave(newValue);
                }
                Navigator.pop(ctx);
              },
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFECE6EF),
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      title: const Align(
        alignment: Alignment.centerRight,
        child: Text(
          'My Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'AudioLinkMono',
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  /// 🔹 Profile Header (icon + name)
  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.black12,
            child: Icon(Icons.person, size: 35, color: Colors.black),
          ),
          SizedBox(width: 12),
          Text(
            "Malik",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Profile Card (Height, Weight, etc.)
  Widget _buildProfileCard() {
    return Container(
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
        children: [
          _ProfileRow(
            title: "Height",
            value: "${height.toStringAsFixed(1)} cm",
            onTap: () => _editValue("Height", height, (val) {
              setState(() => height = val);
            }),
          ),
          const Divider(height: 1, color: Colors.black26),
          _ProfileRow(
            title: "Weight",
            value: "${weight.toStringAsFixed(1)} kg",
            onTap: () => _editValue("Weight", weight, (val) {
              setState(() => weight = val);
            }),
          ),
          const Divider(height: 1, color: Colors.black26),
          _ProfileRow(
              title: "Protein/day", value: "${protein.toStringAsFixed(0)} g"),
          const Divider(height: 1, color: Colors.black26),
          _ProfileRow(
              title: "Calories/day",
              value: "${calories.toStringAsFixed(0)} kcal"),
          const Divider(height: 1, color: Colors.black26),
          _ProfileRow(
              title: "BMI", value: "${bmi.toStringAsFixed(1)} ($bmiCategory)"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildProfileCard(),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Reusable row widget
class _ProfileRow extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onTap;

  const _ProfileRow({required this.title, required this.value, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
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
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
