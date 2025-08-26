import 'package:flutter/material.dart';
import 'navigation/main_navigator.dart'; // Add this import

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'CalistherPal',
      theme: ThemeData.dark(),
      home: const MainNavigator(), // Changed to MainNavigator
    );
  }
}
