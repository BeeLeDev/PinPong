import 'package:flutter/material.dart';
import 'package:pinpong/controller/FireStore.dart';
import 'package:pinpong/leaderBoardPage.dart';
import 'package:pinpong/model/Game.dart';
import 'dart:developer' as dev;

class TriviaGamePage extends StatefulWidget {
  @override
  State<TriviaGamePage> createState() => _TriviaGamePage();
}

class _TriviaGamePage extends State<TriviaGamePage> {
  bool hasFetchedQuestions = false;
  List<Question> triviaQuestions = [];
  List<String> triviaChoices = [];
  Question? currentQuestion;
  int totalQuestions = 0;

  Future<void> loadQuestions() async {
    
    if (!hasFetchedQuestions) {
      triviaQuestions = await fetchTriviaQuestions();
      totalQuestions = triviaQuestions.length;
      currentQuestion = triviaQuestions.removeLast();
      triviaChoices = currentQuestion!.choices;
      hasFetchedQuestions = true;
    }
  }

  void printQuestions() {
    for (Question q in triviaQuestions) {
      dev.log(q.question);
    }
  }

  void handleChoice(String choice) {
    if (correctChoice(choice)) {
      nextPage();
      dev.log("CORRECT");
    } else {
      nextQuestion();
      dev.log("WRONG");
    }
  }

  bool correctChoice(String choice) {
    return choice == currentQuestion!.answer;
  }

  void nextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LeaderBoardPage()),
    );
  }

  void nextQuestion() {
    setState(() {
      currentQuestion = triviaQuestions.removeLast();
      triviaChoices = currentQuestion!.choices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: loadQuestions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while waiting for the data
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Display an error message if an error occurred
              return Text('Error: ${snapshot.error}');
            } else {
              // Display the fetched data
              return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Remaining Questions
            Text(
              (totalQuestions - triviaQuestions.length).toString() + " / " + totalQuestions.toString(),
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.start,
            ),

            const SizedBox(height: 10),
            

            const Text(
              'TRIVIA',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            
            const SizedBox(height: 150),

            // Question
            Text(
              // ! mean can never be null
              currentQuestion!.question,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 180),

            // Answers
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [

                  // Button A
                  ElevatedButton(
                    onPressed: () {
                      handleChoice(triviaChoices[0]);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      triviaChoices[0],
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // BUTTON B
                  ElevatedButton(
                    onPressed: () {
                      handleChoice(triviaChoices[1]);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      triviaChoices[1],
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // BUTTON C
                  ElevatedButton(
                    onPressed: () {
                      handleChoice(triviaChoices[2]);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      triviaChoices[2],
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () {
                      handleChoice(triviaChoices[3]);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.red,
                    ),
                    child:  Text(
                      triviaChoices[3],
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
          ],
        );
            }
          },
        )
      ),
    );
  }
}
