import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinpong/model/Game.dart';
import 'package:pinpong/model/Leaderboard.dart';

import '../model/GameRoom.dart';
import '../model/User.dart';

final db = FirebaseFirestore.instance;

Future<String> login(User user) async {
  // look for the user
  var query = await db
      .collection('users')
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

Future<String> createMockTriviaGameRoom(String userId) async {
  // Mock data for GameRoom
  // Mock data for Trivia game
  Timestamp startTime = Timestamp.now();
  Timestamp endTime =
      Timestamp.fromDate(startTime.toDate().add(Duration(minutes: 30)));
  String instruction = "Follow the instructions carefully!";
  String location = "Random Location";
  GeoPoint geoPoint = GeoPoint(40.7128, -74.0060); // Example: New York City coordinates
  List<String> participants = [];
  Trivia triviaGame = await createMockTriviaGame();

  var game = await db.collection('games').add(triviaGame.toFirestore());
  // Creating a mock GameRoom and attaching the trivia game's document reference
  GameRoom mockGameRoom = GameRoom(
    name: "Trivia#0",
    startTime: startTime,
    endTime: endTime,
    game: game, // Creating a new document reference
    instruction: instruction,
    location: location,
    geoPoint: geoPoint,
    participants: participants,
    name: '',
  );
  var gameroom = await db.collection('gamerooms').add(mockGameRoom.toFirestore());
  return gameroom.id;
}

Future<Trivia> createMockTriviaGame() async {
  int minParticipants = 2;
  int maxParticipants = 4;

  List<Question> triviaQuestions = await fetchTriviaQuestions();

  return Trivia(minParticipants: minParticipants, maxParticipants: maxParticipants, questions: triviaQuestions);
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
  List<GameRoom> filteredGameRooms = gameRooms.where((gameRoom) {
    DateTime startTime = gameRoom.startTime.toDate();
    DateTime endTime = gameRoom.endTime.toDate();

    if (startTime.isBefore(DateTime.now()) && endTime.isAfter(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }).toList();

  return filteredGameRooms;
}

Future<List<Question>> fetchTriviaQuestions() async {
    // Reference to the 'triviaquestion' collection
    CollectionReference<Map<String, dynamic>> triviaCollection = db.collection('triviaquestions');

    // Fetch all documents from the collection
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await triviaCollection.get();

    // Extract data from documents and convert them into Question objects
    List<Question> questions = querySnapshot.docs.map((doc) => Question.fromMap(doc.data() ?? {})).toList();

    return questions;
}
