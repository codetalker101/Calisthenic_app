import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MealAddPage extends StatefulWidget {
  final Map<String, dynamic>? existingMeal; // optional for editing
  final Color textColor;

  const MealAddPage({
    super.key,
    this.existingMeal,
    this.textColor = Colors.black87, // default text color
  });

  @override
  State<MealAddPage> createState() => _MealAddPageState();
}

class _MealAddPageState extends State<MealAddPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _timeController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _ingredientController = TextEditingController();
  final _instructionController = TextEditingController();

  String _difficulty = "Easy";
  String _mealType = "Breakfast"; // default meal type
  List<String> _ingredients = [];
  List<String> _instructions = [];
  File? _mealImage;

  @override
  void initState() {
    super.initState();
    if (widget.existingMeal != null) {
      _titleController.text = widget.existingMeal!["title"] ?? "";
      _subtitleController.text = widget.existingMeal!["subtitle"] ?? "";
      _timeController.text = widget.existingMeal!["time"] ?? "";
      _caloriesController.text =
          (widget.existingMeal!["calories"] ?? "").toString();
      _difficulty = widget.existingMeal!["difficulty"] ?? "Easy";
      _mealType = widget.existingMeal!["mealType"] ?? "Breakfast";
      _ingredients =
          List<String>.from(widget.existingMeal!["ingredients"] ?? []);
      _instructions =
          List<String>.from(widget.existingMeal!["instructions"] ?? []);
      if (widget.existingMeal!["image"] != null) {
        _mealImage = File(widget.existingMeal!["image"]);
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _timeController.dispose();
    _caloriesController.dispose();
    _ingredientController.dispose();
    _instructionController.dispose();
    super.dispose();
  }

  /// Pick Image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _mealImage = File(picked.path));
    }
  }

  /// Add Ingredient
  void _addIngredient() {
    if (_ingredientController.text.isNotEmpty) {
      setState(() {
        _ingredients.add(_ingredientController.text);
        _ingredientController.clear();
      });
    }
  }

  /// Add Instruction
  void _addInstruction() {
    if (_instructionController.text.isNotEmpty) {
      setState(() {
        _instructions.add(_instructionController.text);
        _instructionController.clear();
      });
    }
  }

  /// Save Meal
  void _saveMeal() {
    if (_formKey.currentState!.validate()) {
      final newMeal = {
        "title": _titleController.text,
        "subtitle": _subtitleController.text,
        "time": _timeController.text,
        "difficulty": _difficulty,
        "mealType": _mealType,
        "calories": int.tryParse(_caloriesController.text) ?? 0,
        "ingredients": _ingredients,
        "instructions": _instructions,
        "image": _mealImage?.path,
      };
      print("Meal saved: $newMeal");
      Navigator.pop(context, newMeal);
    }
  }

  /// AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFECE6EF),
      scrolledUnderElevation: 1,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: IconButton(
            enableFeedback: false,
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      title: Text(
        widget.existingMeal == null ? "Add Meal" : "Edit Meal",
        style: TextStyle(
          color: widget.textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          color: Colors.black,
          icon: const Icon(Icons.save),
          onPressed: _saveMeal,
        )
      ],
    );
  }

  /// Image Picker
  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
          image: _mealImage != null
              ? DecorationImage(
                  image: FileImage(_mealImage!), fit: BoxFit.cover)
              : null,
        ),
        child: _mealImage == null
            ? const Center(
                child: Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
              )
            : null,
      ),
    );
  }

  /// Text Fields (Title, Subtitle, Time, Calories)
  Widget _buildTextFields() {
    final textStyle = TextStyle(color: widget.textColor);
    return Column(
      children: [
        TextFormField(
          controller: _titleController,
          style: textStyle,
          decoration: InputDecoration(
            labelText: "Meal Name",
            labelStyle: TextStyle(color: widget.textColor),
          ),
          validator: (value) =>
              value == null || value.isEmpty ? "Enter a meal name" : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _subtitleController,
          style: textStyle,
          decoration: InputDecoration(
            labelText: "Meal Description",
            labelStyle: TextStyle(color: widget.textColor),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _timeController,
                style: textStyle,
                decoration: InputDecoration(
                  labelText: "Time to Make",
                  labelStyle: TextStyle(color: widget.textColor),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: _caloriesController,
                style: textStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Calories",
                  labelStyle: TextStyle(color: widget.textColor),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Dropdowns (Difficulty & Meal Type)
  Widget _buildDropdowns() {
    final textStyle = TextStyle(color: widget.textColor);
    return Column(
      children: [
        DropdownButtonFormField<String>(
          enableFeedback: false,
          value: _difficulty,
          dropdownColor: Colors.white,
          items: ["Easy", "Medium", "Hard"]
              .map((t) => DropdownMenuItem(
                    value: t,
                    child: Text(t, style: textStyle),
                  ))
              .toList(),
          onChanged: (val) => setState(() => _difficulty = val!),
          decoration: InputDecoration(
            labelText: "Difficulty",
            labelStyle: TextStyle(color: widget.textColor),
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          enableFeedback: false,
          value: _mealType,
          dropdownColor: Colors.white,
          items: ["Breakfast", "Lunch", "Snack", "Dinner"]
              .map((t) => DropdownMenuItem(
                    value: t,
                    child: Text(t, style: textStyle),
                  ))
              .toList(),
          onChanged: (val) => setState(() => _mealType = val!),
          decoration: InputDecoration(
            labelText: "Meal Type",
            labelStyle: TextStyle(color: widget.textColor),
          ),
        ),
      ],
    );
  }

  /// Ingredients Section
  Widget _buildIngredients() {
    final textStyle = TextStyle(color: widget.textColor);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Ingredients",
            style: textStyle.copyWith(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _ingredientController,
                style: textStyle,
                decoration: const InputDecoration(hintText: "Add ingredient"),
              ),
            ),
            IconButton(icon: const Icon(Icons.add), onPressed: _addIngredient)
          ],
        ),
        Column(
          children: _ingredients.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final ing = entry.value;
            return ListTile(
              title: Text("$index. $ing", style: textStyle),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => setState(() => _ingredients.remove(ing)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// Instructions Section
  Widget _buildInstructions() {
    final textStyle = TextStyle(color: widget.textColor);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Instructions",
            style: textStyle.copyWith(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _instructionController,
                style: textStyle,
                decoration:
                    const InputDecoration(hintText: "Add instruction step"),
              ),
            ),
            IconButton(icon: const Icon(Icons.add), onPressed: _addInstruction),
          ],
        ),
        Column(
          children: _instructions.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final step = entry.value;
            return ListTile(
              title: Text("$index. $step", style: textStyle),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => setState(() => _instructions.remove(step)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImagePicker(),
              const SizedBox(height: 20),
              _buildTextFields(),
              const SizedBox(height: 12),
              _buildDropdowns(),
              const SizedBox(height: 20),
              _buildIngredients(),
              const SizedBox(height: 20),
              _buildInstructions(),
            ],
          ),
        ),
      ),
    );
  }
}
