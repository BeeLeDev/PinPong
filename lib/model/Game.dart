import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Game {
  int minParticipants;
  int maxParticipants;

  Game(this.minParticipants, this.maxParticipants);
}

class Trivia extends Game {
  List<Question> triviaQuestions = [];
  List<Map<String, int>> leaderboard = [];

  Trivia({
    required int minParticipants,
    required int maxParticipants,
    required List<Question> questions,
    required List<Map<String, int>> leaderboard,
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
    var leaderboard = List<Map<String, int>>.from(data?['leaderboard'] ?? []);

    return Trivia(
      minParticipants: data?['minParticipants'] ?? 0,
      maxParticipants: data?['maxParticipants'] ?? 0,
      questions: questions,
      leaderboard: leaderboard,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "minParticipants": minParticipants,
      "maxParticipants": maxParticipants,
      "triviaQuestions": triviaQuestions.map((q) => q.toMap()).toList(),
      "leaderboard" : triviaQuestions.map((l) => l.toMap()).toList(),
    };
  }
}

class Question {
  String question;
  List<String> answers;
  String correctAnswer;

  Question({
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['question'] ?? '',
      answers: List<String>.from(map['answers'] ?? []),
      correctAnswer: map['correctAnswer'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answers': answers,
      'correctAnswer': correctAnswer,
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