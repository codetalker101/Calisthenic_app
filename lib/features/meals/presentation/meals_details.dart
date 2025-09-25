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
  int selectedTab = 0; // 0 = Ingredients, 1 = Instructions

  /// AppBar
  AppBar _buildAppBar() {
    return AppBar(
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
              color: Color(0xFF4A4A4A),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFECE6EF),
            child: IconButton(
              enableFeedback: false,
              icon: SvgPicture.asset(
                'assets/icons/pencilEdit.svg',
                width: 20,
                height: 20,
                color: Color(0xFF4A4A4A),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  /// Food Image
  Widget _buildFoodImage() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      child: Image.asset(
        widget.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  /// Draggable Sheet Content
  Widget _buildDraggableContent(
      BuildContext context, ScrollController scrollController) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isFullScreen =
            constraints.maxHeight == MediaQuery.of(context).size.height;

        return Material(
          elevation: 1,
          color: const Color(0xFFECE6EF),
          borderRadius: isFullScreen
              ? BorderRadius.zero
              : const BorderRadius.vertical(top: Radius.circular(24)),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHandle(),
                  _buildTitleAndDescription(),
                  _buildInfoRow(),
                  const Divider(thickness: 1, color: Colors.black12),
                  const SizedBox(height: 5),
                  _buildTabSwitcher(),
                  const SizedBox(height: 10),
                  _buildTabContent(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Handle Strip
  Widget _buildHandle() {
    return Center(
      child: Container(
        width: 90,
        height: 3,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  /// Food Name + Description
  Widget _buildTitleAndDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        Text(
          widget.description,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  /// Info Row (time, difficulty, calories)
  Widget _buildInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _infoItem("assets/icons/clockIcon.svg", widget.time),
        const SizedBox(width: 15),
        _infoItem("assets/icons/GraphLvlIcon.svg", widget.difficulty),
        const SizedBox(width: 15),
        _infoItem("assets/icons/CaloriesBurntIcon.svg", widget.calories),
      ],
    );
  }

  Widget _infoItem(String iconPath, String text) {
    return Row(
      children: [
        SvgPicture.asset(iconPath,
            width: 12, height: 12, color: Colors.black45),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 11, color: Colors.black45)),
      ],
    );
  }

  /// Tab Switcher (Ingredients / Instructions)
  Widget _buildTabSwitcher() {
    return Center(
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
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: Align(
                  key: ValueKey<int>(selectedTab),
                  alignment: selectedTab == 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    width: 105,
                    height: 33,
                    color: const Color(0xFF9B2354),
                  ),
                ),
              ),
              Row(
                children: [
                  _tabButton(
                      "assets/icons/todolistIcons.svg", "Ingredients", 0),
                  Container(width: 1, height: 20, color: Colors.black26),
                  _tabButton(
                      "assets/icons/cookingInstruction.svg", "Instructions", 1),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabButton(String iconPath, String label, int index) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 14,
                height: 14,
                color: isSelected ? Colors.white : Colors.black87,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Tab Content (Ingredients / Instructions)
  Widget _buildTabContent() {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 250),
      crossFadeState: selectedTab == 0
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstChild: _buildIngredientsCard(),
      secondChild: _buildInstructionsCard(),
    );
  }

  Widget _buildIngredientsCard() {
    return _buildCard(
      "Ingredients",
      widget.ingredients.map((item) => "• $item").toList(),
    );
  }

  Widget _buildInstructionsCard() {
    return _buildCard("Instructions", widget.instructions);
  }

  Widget _buildCard(String title, List<String> items) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Divider(thickness: 1, color: Colors.black26),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.asMap().entries.map((entry) {
                final i = entry.key;
                final text = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(text, style: const TextStyle(color: Colors.black)),
                    if (i != items.length - 1)
                      const Divider(thickness: 1, color: Colors.black12),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFECE6EF),
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildFoodImage(),
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.55,
            maxChildSize: 1.0,
            builder: _buildDraggableContent,
          ),
        ],
      ),
    );
  }
}
