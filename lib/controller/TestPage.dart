import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinpong/controller/FireStore.dart';
import 'package:pinpong/controller/TriviaGameController.dart';
import 'package:pinpong/model/Game.dart';
import 'package:pinpong/model/Leaderboard.dart';
import 'package:pinpong/model/User.dart';

import '../model/GameRoom.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  void _login () async {
    final user = User(name: "Gibeom Choi", studentId: "02028223");
    String result = await login(user);
    print(result);
  }

  void _createRoom () async {
    final user = User(name: "Gibeom Choi", studentId: "02028223");
    String result = await login(user);

    print(await createMockTriviaGameRoom(result));
  }

  void _readRooms() async {
    print(await readGameRooms());
  }

  void _joinRoom() async {
    final user = User(name: "Gibeom Choi", studentId: "02028223");
    String userid = await login(user);


    var result = await readGameRooms();
    GameRoom gameroomRef = await result[0];
    await joinTriviaGame(gameroomRef.game.id, userid);
  }

  void _getQuestions() async {
    final user = User(name: "Gibeom Choi", studentId: "02028223");
    String userid = await login(user);


    var result = await readGameRooms();
    GameRoom gameroomRef = await result[0];

    var trivia = await readTriviaGame(gameroomRef.game.id);

    print(trivia.triviaQuestions[0].question);
    print(trivia.triviaQuestions[0].answer);
  }

  void _answer() async {
    final user = User(name: "Gibeom Choi", studentId: "02028223");
    String userid = await login(user);

    var result = await readGameRooms();
    GameRoom gameroomRef = await result[0];

    await updateTriviaScore(gameroomRef.game.id, userid, 0, "Dorchester");
  }

  void _readLeaderboard() async {
    var result = await readGameRooms();
    GameRoom gameroomRef = result[0];

    var something = await readLeaderboard(gameroomRef.game.id);
    for (var each in something) {
      User user = each.keys.first;
      Leaderboard leaderboard = each.values.first;

      print(user.name);
      print(leaderboard.score);
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("TestPage"),
          titleTextStyle: TextStyle(
            color: Colors.blue,
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Text("Hello World"),
              ElevatedButton(
                  onPressed: () => _login(),
                  child: Text("Login")),
              ElevatedButton(
                  onPressed: () => _createRoom(),
                  child: Text("CreateRoom")),
              ElevatedButton(
                  onPressed: () => _readRooms(),
                  child: Text("Check Rooms")),
              ElevatedButton(
                  onPressed: () => _joinRoom(),
                  child: Text("Join Room")),
              ElevatedButton(
                  onPressed: () => _getQuestions(),
                  child: Text("Questions")),
              ElevatedButton(
                  onPressed: () => _answer(),
                  child: Text("Answer")),
              ElevatedButton(
                  onPressed: () => _readLeaderboard(),
                  child: Text("Leaderboard")),
            ],
          ),
        )
      )
    );
  }
}