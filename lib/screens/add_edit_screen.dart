
// lib/screens/add_edit_flashcard_screen.dart
import 'package:flash_card/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/models/flash_card_model.dart';
import 'dart:math';

class AddEditFlashcardScreen extends StatefulWidget {
  final Flashcard? initialFlashcard;
  final Function(Flashcard) onSave;

  const AddEditFlashcardScreen({
    super.key,
    this.initialFlashcard,
    required this.onSave,
  });

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
          color: Colors.white,
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
                    CustomTextField(answerController: _answerController, label: "Answer"),
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
        enabledBorder:  const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black,

            ),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        labelText: label,
        labelStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 18
        ),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xffdc3838),
                width: 1.5
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xffE05151),
                width: 2.5
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black,
                width: 2
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter an ${label}';
        }
        return null;
      },
      maxLines: 3,
    );
  }
}