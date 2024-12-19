import 'package:flash_card/screens/Example.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcard App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      // home: Example(),
    );

  }
}