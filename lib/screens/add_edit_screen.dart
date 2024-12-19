
// lib/screens/add_edit_flashcard_screen.dart
import 'package:flash_card/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/models/flash_card_model.dart';
import 'dart:math';

class AddEditFlashcardScreen extends StatefulWidget {
  final Flashcard? initialFlashcard;
  final Function(Flashcard) onSave;

  const AddEditFlashcardScreen({
    Key? key,
    this.initialFlashcard,
    required this.onSave,
  }) : super(key: key);

  @override
  _AddEditFlashcardScreenState createState() => _AddEditFlashcardScreenState();
}

class _AddEditFlashcardScreenState extends State<AddEditFlashcardScreen> {
  late TextEditingController _questionController;
  late TextEditingController _answerController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(
      text: widget.initialFlashcard?.question ?? '',
    );
    _answerController = TextEditingController(
      text: widget.initialFlashcard?.answer ?? '',
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  void _saveFlashcard() {
    if (_formKey.currentState!.validate()) {
      final flashcard = Flashcard(
        id: widget.initialFlashcard?.id ?? _generateId(),
        question: _questionController.text.trim(),
        answer: _answerController.text.trim(),
      );
      widget.onSave(flashcard);
      Navigator.pop(context);
    }
  }

  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString() +
        Random().nextInt(1000).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight:Radius.circular(20)
          )
        ),
        child: Column(
          children: [
            const SizedBox(height: 25),
            Text(
                widget.initialFlashcard == null
                    ? 'Add Flashcard'
                    : 'Edit Flashcard'
                    ,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(answerController: _questionController, label: "Question",),
                    const SizedBox(height: 16),
                    CustomTextField(answerController: _answerController, label: "Answers"),
                    const SizedBox(height: 16),
                    CustomButton(onPressed:_saveFlashcard, text: "Save Flashcard")
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController answerController,
    required this.label
  }) : _answerController = answerController;

  final TextEditingController _answerController;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      cursorHeight: 30,
      cursorWidth: 2,
      style:  const TextStyle(
          fontSize: 18,
         fontWeight: FontWeight.w500
      ),
      controller: _answerController,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black
            )
        ),
        labelText: label,
        labelStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 18
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black,
                width: 2
            )
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter an answer';
        }
        return null;
      },
      maxLines: 3,
    );
  }
}