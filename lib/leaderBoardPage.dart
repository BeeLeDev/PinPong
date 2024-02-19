import 'package:flutter/material.dart';
import 'package:pinpong/homepage.dart';

class LeaderBoardPage extends StatelessWidget {
  int correctAnswer = 0;
  LeaderBoardPage(this.correctAnswer, {super.key});

  List<String> leaderboardEntries = [
  ];

  @override
  Widget build(BuildContext context) {
    leaderboardEntries.add("Brandon : $correctAnswer");

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 120),
            const Text(
              'Leaderboard',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            const Text(
              'Trivia',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 116, 116, 116)),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 100),
            ListView.builder(
              physics:
                  const NeverScrollableScrollPhysics(), // to disable ListView's own scrolling inside a SingleChildScrollView
              shrinkWrap: true,
              itemCount: leaderboardEntries.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Text(
                    leaderboardEntries[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              },
            ),
            const SizedBox(height: 80),
            const Text(
              'Superman won 100 times in a row!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.start,
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 80),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage(
                                      title: '',
                                    )),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Colors.red,
                        ),
                        child: const Text(
                          'Leave',
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
        ),
      ),
    );
  }
}
