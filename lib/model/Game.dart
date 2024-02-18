import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Game {
  int minParticipants;
  int maxParticipants;

  Game(this.minParticipants, this.maxParticipants);
}

class Trivia extends Game {
  List<Question> triviaQuestions = [];

  Trivia({
    required int minParticipants,
    required int maxParticipants,
    required List<Question> questions,
  }) : super(minParticipants, maxParticipants) {
    triviaQuestions = questions;
  }

  factory Trivia.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    List<Question> questions = [];
    if (data?['triviaQuestions'] is Iterable) {
      questions = List<Question>.from(
        data?['triviaQuestions'].map((q) => Question.fromMap(q)) ?? [],
      );
    }

    return Trivia(
      minParticipants: data?['minParticipants'] ?? 0,
      maxParticipants: data?['maxParticipants'] ?? 0,
      questions: questions,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "minParticipants": minParticipants,
      "maxParticipants": maxParticipants,
      "triviaQuestions": triviaQuestions.map((q) => q.toMap()).toList(),
    };
  }
}

class Question {
  String question;
  List<String> choices;
  String answer;

  Question({
    required this.question,
    required this.choices,
    required this.answer,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['question'] ?? '',
      choices: List<String>.from(map['choices'] ?? []),
      answer: map['answer'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'choices': choices,
      'answer': answer,
    };
  }
}

class FindImposter extends Game {
  List<String> instruction = [];

  FindImposter({
    required int minParticipants,
    required int maxParticipants,
  }) : super(minParticipants, maxParticipants);
}