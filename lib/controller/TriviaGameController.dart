import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinpong/model/Leaderboard.dart';

import '../model/Game.dart';
import '../model/GameRoom.dart';

final db = FirebaseFirestore.instance;

Future<Trivia> readTriviaGame(String gameId) async {
  var query = await db.collection('games').doc(gameId).get();

  if (!query.exists) {
    throw Exception("No Such Game");
  }

  return Trivia.fromFirestore(query, null);
}

Future<void> joinTriviaGame(String gameId, String userId) async {
  var query = await db.collection('gamerooms')
    .where('game', isEqualTo: db.doc('games/$gameId'))
    .get();

  if (query.docs.isEmpty) {
    throw Exception("No Such GameID $gameId");
  }

  var gameRoomRef = GameRoom.fromFirestore(query.docs[0], null);
  if (gameRoomRef.participants.contains(userId)) {
    return;
  }
  gameRoomRef.participants.add(userId);
  return await db.collection('gamerooms').doc(query.docs[0].id).update(gameRoomRef.toFirestore());
}

Future<void> updateTriviaScore(String gameId, String userId, int questionNum, String answer) async {
  Trivia trivia = Trivia.fromFirestore(await db.collection('games').doc(gameId).get(), null);

  //if (trivia.triviaQuestions[questionNum] )

  // var score = Leaderboard(gameId, userId, score)
  // var query = await db.collection('leaderboard').add()
}

void readLeaderboard(String gameId, String userId) {}