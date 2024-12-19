
// lib/screens/home_screen.dart
import 'dart:convert';

import 'package:flash_card/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/flash_card_item.dart';
import 'package:flash_card/models/flash_card_model.dart';
import 'add_edit_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   List<Flashcard> _flashcards = [];


  @override
  void initState() {
    super.initState();
    _loadFlashcards();
  }

  // Load flashcards from SharedPreferences
  Future<void> _loadFlashcards() async {
    final prefs = await SharedPreferences.getInstance();
    final String? flashcardsJson = prefs.getString('flashcards');
    if (flashcardsJson != null) {
      final List<dynamic> decodedJson = jsonDecode(flashcardsJson);
      setState(() {
        _flashcards = decodedJson.map((item) => Flashcard.fromJson(item)).toList();
      });
    }
  }
   Future<void> _saveFlashcards() async {
     final prefs = await SharedPreferences.getInstance();
     final String encodedJson = jsonEncode(_flashcards.map((f) => f.toJson()).toList());
     await prefs.setString('flashcards', encodedJson);
   }

   void _addFlashcard(Flashcard flashcard) {
    setState(() {
      _flashcards.add(flashcard);
    });
    _saveFlashcards();
  }

  void _updateFlashcard(Flashcard updatedFlashcard) {
    setState(() {
      final index = _flashcards.indexWhere((f) => f.id == updatedFlashcard.id);
      if (index != -1) {
        _flashcards[index] = updatedFlashcard;
      }
    });
    _saveFlashcards();
  }

  void _deleteFlashcard(Flashcard flashcard) {
    setState(() {
      _flashcards.removeWhere((f) => f.id == flashcard.id);
    });
    _saveFlashcards();
  }

  void _showAddFlashcard() {
    showModalBottomSheet(context: context, builder: (context)=>AddEditFlashcardScreen(
              onSave: _addFlashcard,
            ),
   );
  }
  // void _navigateToAddFlashcard() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => AddEditFlashcardScreen(
  //         onSave: _addFlashcard,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  const Text('Flashcard App'),
        centerTitle: true,
      ),
      body: _flashcards.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/add-file.png",
            scale: 0.2,
            width: 100,),
            const Text(
              'No flashcards yet!',
             style:  TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey
        ),
            ),
            const SizedBox(height: 16),
            CustomButton(onPressed: _showAddFlashcard, text: "Create First Flashcard")
          ],
        ),
      )
          : ListView.builder(
        itemCount: _flashcards.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: FlashcardItem(
                total: _flashcards.length,
                currentIndex: index,
                flashcard: _flashcards[index],
                onDelete: _deleteFlashcard,
                onUpdate: _updateFlashcard,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: _showAddFlashcard,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}