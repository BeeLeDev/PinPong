import 'package:cloud_firestore/cloud_firestore.dart';

class Leaderboard {
  String gameId;
  String userId;
  int score;

  Leaderboard(this.gameId, this.userId, this.score);
}