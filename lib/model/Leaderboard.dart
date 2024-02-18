import 'package:cloud_firestore/cloud_firestore.dart';

class Leaderboard {
  String gameId;
  String userId;
  int score;

  Leaderboard({required this.gameId, required this.userId, required this.score});

  factory Leaderboard.fromMap(Map<String, dynamic> map) {
    return Leaderboard(
      gameId: map['gameId'] ?? '',
      userId: map['userId'] ?? '',
      score: map['score'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'gameId': gameId,
      'userId': userId,
      'score': score,
    };
  }
}