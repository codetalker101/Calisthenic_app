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
  String _difficulty = "Easy";
  String _mealType = "Breakfast"; // 👈 default meal type

  List<String> _ingredients = [];
  List<String> _instructions = [];

  final _ingredientController = TextEditingController();
  final _instructionController = TextEditingController();

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
      _mealType =
          widget.existingMeal!["mealType"] ?? "Breakfast"; // 👈 load type
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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _mealImage = File(picked.path);
      });
    }
  }

  void _addIngredient() {
    if (_ingredientController.text.isNotEmpty) {
      setState(() {
        _ingredients.add(_ingredientController.text);
        _ingredientController.clear();
      });
    }
  }

  void _addInstruction() {
    if (_instructionController.text.isNotEmpty) {
      setState(() {
        _instructions.add(_instructionController.text);
        _instructionController.clear();
      });
    }
  }

  void _saveMeal() {
    if (_formKey.currentState!.validate()) {
      final newMeal = {
        "title": _titleController.text,
        "subtitle": _subtitleController.text,
        "time": _timeController.text,
        "difficulty": _difficulty,
        "mealType": _mealType, // 👈 added meal type
        "calories": int.tryParse(_caloriesController.text) ?? 0,
        "ingredients": _ingredients,
        "instructions": _instructions,
        "image": _mealImage?.path,
      };

      print("Meal saved: $newMeal");
      Navigator.pop(context, newMeal); // return the meal
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: widget.textColor);

    return Scaffold(
      backgroundColor: const Color(0xFFECE6EF),
      appBar: AppBar(
        scrolledUnderElevation: 1,
        backgroundColor: const Color(0xFFECE6EF),
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
          style: textStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            color: Colors.black,
            icon: const Icon(Icons.save),
            onPressed: _saveMeal,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Meal image picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                    image: _mealImage != null
                        ? DecorationImage(
                            image: FileImage(_mealImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _mealImage == null
                      ? const Center(
                          child: Icon(Icons.add_a_photo,
                              size: 50, color: Colors.grey),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 20),

              // Meal title
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

              // Subtitle
              TextFormField(
                controller: _subtitleController,
                style: textStyle,
                decoration: InputDecoration(
                  labelText: "Meal Description",
                  labelStyle: TextStyle(color: widget.textColor),
                ),
              ),
              const SizedBox(height: 12),

              // Time & Calories
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
                      decoration: InputDecoration(
                        labelText: "Calories",
                        labelStyle: TextStyle(color: widget.textColor),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Difficulty dropdown
              DropdownButtonFormField<String>(
                enableFeedback: false, // no click sound
                initialValue: _difficulty,
                dropdownColor:
                    Colors.white, // background color of dropdown menu
                items: ["Easy", "Medium", "Hard"]
                    .map((t) => DropdownMenuItem(
                          value: t,
                          child: Text(
                            t,
                            style: TextStyle(
                                color: widget.textColor), // item text color
                          ),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _difficulty = val!),
                decoration: InputDecoration(
                  labelText: "Difficulty",
                  labelStyle: TextStyle(color: widget.textColor),
                ),
              ),
              const SizedBox(height: 12),

              // 👇 Meal type dropdown
              DropdownButtonFormField<String>(
                enableFeedback: false, // no click sound
                initialValue: _mealType,
                dropdownColor:
                    Colors.white, // background color of dropdown menu
                style: TextStyle(
                    color: widget.textColor), // text color inside menu
                items: ["Breakfast", "Lunch", "Snack", "Dinner"]
                    .map((t) => DropdownMenuItem(
                          value: t,
                          child: Text(
                            t,
                            style: TextStyle(
                                color: widget.textColor), // 👈 item text color
                          ),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _mealType = val!),
                decoration: InputDecoration(
                  labelText: "Meal Type",
                  labelStyle: TextStyle(color: widget.textColor),
                ),
              ),
              const SizedBox(height: 20),

              // Ingredients
              Text("Ingredients",
                  style: textStyle.copyWith(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ingredientController,
                      style: textStyle,
                      decoration:
                          const InputDecoration(hintText: "Add ingredient"),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addIngredient,
                  )
                ],
              ),
              // Numbering each ingredient
              Column(
                children: _ingredients.asMap().entries.map((entry) {
                  final index = entry.key + 1; // start numbering from 1
                  final ing = entry.value;
                  return ListTile(
                    title: Text(
                      "$index. $ing", // 👈 prepend number
                      style: textStyle,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => setState(() => _ingredients.remove(ing)),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Instructions
              Text("Instructions",
                  style: textStyle.copyWith(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _instructionController,
                      style: textStyle,
                      decoration: const InputDecoration(
                          hintText: "Add instruction step"),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addInstruction,
                  )
                ],
              ),
              // Numbering each instruction
              Column(
                children: _instructions.asMap().entries.map((entry) {
                  final index = entry.key + 1;
                  final step = entry.value;
                  return ListTile(
                    title: Text(
                      "$index. $step", // 👈 prepend number
                      style: textStyle,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          setState(() => _instructions.remove(step)),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
