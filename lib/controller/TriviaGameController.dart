import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinpong/leaderBoardPage.dart';
import 'package:pinpong/model/Leaderboard.dart';
import 'package:pinpong/model/User.dart';

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
  await db.collection('leaderboard').add(Leaderboard(gameId: gameId, userId: userId, score: 0).toMap());
  return await db.collection('gamerooms').doc(query.docs[0].id).update(gameRoomRef.toFirestore());
}

Future<void> updateTriviaScore(String gameId, String userId, int questionNum, String answer) async {
  Trivia trivia = Trivia.fromFirestore(await db.collection('games').doc(gameId).get(), null);

  if (trivia.triviaQuestions[questionNum].answer != answer) {
    return;
  }

  var query = await db.collection('leaderboard')
      .where('gameId', isEqualTo: gameId)
      .where('userId', isEqualTo: userId)
      .get();

  if (query.docs.isEmpty) {
    throw Exception("No such leaderboard");
  }
  var leader = Leaderboard.fromMap(query.docs[0].data());

  leader.score += 1;
  return await db.collection('leaderboard').doc(query.docs[0].id).update(leader.toMap());
}

Future<List<Map<User, Leaderboard>>> readLeaderboard(String gameId) async {
  var query = await db.collection('leaderboard')
      .where(gameId)
      .get();

  List<Map<User, Leaderboard>> answer = [];

  for (var element in query.docs) {
    Leaderboard l = Leaderboard.fromMap(element.data());
    User user = await findUserById(l.userId); // Assuming you have a function to find a user by ID

    answer.add({user: l});
  }

  return answer;
}

Future<User> findUserById(String userId) async {
  var query = await db.collection('users').doc(userId).get();

  return User.fromMap(query.data()!);
}