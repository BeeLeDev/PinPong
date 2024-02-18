import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinpong/controller/FireStore.dart';
import 'package:pinpong/controller/TriviaGameController.dart';
import 'package:pinpong/model/Game.dart';
import 'package:pinpong/model/User.dart';

import '../model/GameRoom.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  void _login () async {
    final user = User("Gibeom Choi", "02028223");
    String result = await login(user);
    print(result);
  }

  void _createRoom () async {
    print(await createMockTriviaGameRoom());
  }

  void _readRooms() async {
    print(await readGameRooms());
  }

  void _joinRoom() async {
    final user = User("Gibeom Choi", "02028223");
    String userid = await login(user);


    var result = await readGameRooms();
    GameRoom gameroomRef = await result[0];
    await joinTriviaGame(gameroomRef.game.id, userid);
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
                  child: Text("Join Room"))
            ],
          ),
        )
      )
    );
  }
}