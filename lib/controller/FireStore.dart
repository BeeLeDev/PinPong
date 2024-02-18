import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinpong/model/Game.dart';

import '../model/GameRoom.dart';
import '../model/User.dart';

final db = FirebaseFirestore.instance;

Future<String> login(User user) async {
  // look for the user
  var query = await db.collection('users')
      .where("studentId", isEqualTo: user.studentId)
      .get();
  // if exists, return the user doc-id;
  if (query.docs.isNotEmpty) {
    return query.docs[0].id;
  }
  // otherwiser, return the user doc-id after saving the user;
  var docRef = await db.collection('users').add(user.toMap());
  return docRef.id;
}

Future<String> createMockTriviaGameRoom() async {
  // Mock data for GameRoom
  // Mock data for Trivia game
  Timestamp startTime = Timestamp.now();
  Timestamp endTime = Timestamp.fromDate(startTime.toDate().add(Duration(minutes: 30)));
  String instruction = "Follow the instructions carefully!";
  String location = "Random Location";
  GeoPoint geoPoint = GeoPoint(40.7128, -74.0060); // Example: New York City coordinates
  List<String> participants = ["Player1", "Player2", "Player3"];
  Trivia triviaGame = createMockTriviaGame();

  var game = await db.collection('games').add(triviaGame.toFirestore());
  // Creating a mock GameRoom and attaching the trivia game's document reference
  GameRoom mockGameRoom = GameRoom(
    name: "bam",
    startTime: startTime,
    endTime: endTime,
    game: game, // Creating a new document reference
    instruction: instruction,
    location: location,
    geoPoint: geoPoint,
    participants: participants,
  );

  var gameroom = await db.collection('gamerooms').add(mockGameRoom.toFirestore());
  return gameroom.id;
}

Trivia createMockTriviaGame() {
  int minParticipants = 2;
  int maxParticipants = 4;

  List<Question> triviaQuestions = [
    Question(
      question: "What is the capital of France?",
      answers: ["Berlin", "Madrid", "Paris", "Rome"],
      correctAnswer: "Paris",
    ),
    Question(
      question: "Which planet is known as the Red Planet?",
      answers: ["Earth", "Mars", "Jupiter", "Venus"],
      correctAnswer: "Mars",
    ),
  ];

  return Trivia(minParticipants: minParticipants, maxParticipants: maxParticipants, questions: triviaQuestions, leaderboard: []);
}

Future<List<GameRoom>> readGameRooms() async {
    // Query Firestore for GameRooms that meet the criteria
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('gamerooms').get();

    // Convert the documents to GameRoom instances
    List<GameRoom> gameRooms = querySnapshot.docs.map((doc) {
      return GameRoom.fromFirestore(doc, null);
    }).toList();

    // Filter GameRooms based on start and end times
    List<GameRoom> filteredGameRooms = gameRooms
        .where((gameRoom) {
        DateTime startTime = gameRoom.startTime.toDate();
        DateTime endTime = gameRoom.endTime.toDate();

        if (startTime.isBefore(DateTime.now()) &&
            endTime.isAfter(DateTime.now())) {
          return true;
        } else {
          return false;
        }
      })
        .toList();

    return filteredGameRooms;
}

