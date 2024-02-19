import 'package:flutter/material.dart';
import 'package:pinpong/controller/FireStore.dart';
import 'package:pinpong/model/GameRoom.dart';
import 'package:pinpong/triviaGame.dart';

class GameLobbyPage extends StatelessWidget {
  GameLobbyPage({Key? key}) : super(key: key);
  List<GameRoom> gameRooms = [];

  Future<void> fetchGameRooms() async {
    gameRooms = await readGameRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<void>(
        future: fetchGameRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for the future to complete
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Display an error message if the future encountered an error
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: gameRooms.length,
              itemBuilder: (context, index) {
                final gameRoom = gameRooms[index];
                var participants = gameRoom.participants.length.toString();
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/cc.jpg'),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Campus Center',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Trivia!',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Test your knowledge against other players on a variety of trivia questions.\n\nSolve as many questions as you can within the time limit.',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 30),
                            Text(
                              '4m left until the next game.',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 340),
                    SafeArea(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '$participants people waiting for the next game...',
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TriviaGamePage(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50),
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text(
                                  'Join Queue',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
