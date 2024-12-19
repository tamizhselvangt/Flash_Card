


class Flashcard {
  String id;
  String question;
  String answer;

  Flashcard({
    required this.id,
    required this.question,
    required this.answer,
  });

  // Convert a Flashcard into a Map
  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
    'answer': answer,
  };

  // Create a Flashcard from a Map
  factory Flashcard.fromJson(Map<String, dynamic> json) => Flashcard(
    id: json['id'],
    question: json['question'],
    answer: json['answer'],
  );
}
