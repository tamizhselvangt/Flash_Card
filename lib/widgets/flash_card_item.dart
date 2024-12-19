import 'package:flash_card/widgets/custom_button.dart';
import 'package:flash_card/widgets/flash_card.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/screens/add_edit_screen.dart';

import '../models/flash_card_model.dart';

class FlashcardItem extends StatefulWidget {
  final Flashcard flashcard;
  final Function(Flashcard) onDelete;
  final Function(Flashcard) onUpdate;
  final int total;
  final int currentIndex;

  const FlashcardItem({
    Key? key,
    required this.flashcard,
    required this.onDelete,
    required this.onUpdate,
    required this.total,
    required this.currentIndex
  }) : super(key: key);

  @override
  _FlashcardItemState createState() => _FlashcardItemState();
}

class _FlashcardItemState extends State<FlashcardItem> {

  void _editFlashcard() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddEditFlashcardScreen(
        initialFlashcard: widget.flashcard,
        onSave: widget.onUpdate,
      ),
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Flashcard'),
        content: const Text('Are you sure you want to delete this flashcard?',
        style: TextStyle(
          fontSize: 16
        ),),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
             style: TextStyle(
               color: Colors.black,
               fontSize: 16
             ),),
          ),
          CustomButton(
              onPressed: () {
                widget.onDelete(widget.flashcard);
                Navigator.pop(context);
              },
              text: 'Delete')
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlashCard(
      width: MediaQuery.of(context).size.width * 0.9,
        height:  MediaQuery.of(context).size.width * 0.6,
        frontWidget: FlashCardContent(widget: widget, onPressed: (){
          _confirmDelete();
        }, label: "Answer"),
        backWidget: FlashCardContent(widget: widget, onPressed:(){
          _editFlashcard();
        }, label: "Question")
    );
  }
}


// FlashCard Content. Front and Back (Question and Answer)
class FlashCardContent extends StatelessWidget {

  final dynamic onPressed;
  final String label;

  const FlashCardContent({
    super.key,
    required this.widget,
    required Function this.onPressed,
    required String this.label
  });

  final FlashcardItem widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("${label}: ${widget.total}/${widget.currentIndex+1}",
          style: const TextStyle(
              fontSize: 16
          ),),
        Expanded(
          child: Center(
            child: Text(
             label == "Question" ? widget.flashcard.question : widget.flashcard.answer,
              style: const TextStyle(
                color:  Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment:  label == "Question" ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            IconButton(
              icon:  Icon(
                  size: 30,
                  label == "Question" ? Icons.edit_note_rounded : Icons.delete_forever_outlined,
                  color: Colors.black45),
              onPressed: onPressed,
            ),
          ],
        )
      ],
    );
  }
}
