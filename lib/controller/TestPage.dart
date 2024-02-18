import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinpong/controller/FireStore.dart';
import 'package:pinpong/controller/TriviaGameController.dart';
import 'package:pinpong/model/Game.dart';
import 'package:pinpong/model/User.dart';
import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:pinpong/model/Location.dart';

import '../model/GameRoom.dart';

final db = FirebaseFirestore.instance;

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

  void _checkLocation() async {
    var query = await db.collection('gamerooms').get();
    var docs = query.docs[0].data();
    var geoPoints = docs['geoPoint'];
    var longitude = geoPoints['longitude'];
    var latitude = geoPoints['latitude'];

    if (await inRadius(latitude, longitude)) {
      print("Passed");
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
                  onPressed: () =>  _checkLocation() , 
                  child: Text("Location")),
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