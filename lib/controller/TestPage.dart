import 'package:flutter/material.dart';
import 'package:pinpong/controller/FireStore.dart';
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
                  child: Text("Check Rooms"))
            ],
          ),
        )
      )
    );
  }
}