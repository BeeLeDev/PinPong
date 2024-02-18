import 'package:flutter/material.dart';
import 'package:pinpong/gameLobbyPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Row(
          // Add Row here
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Expanded(child: SizedBox()),
            Image.asset(
              'assets/sign_out.png',
              scale: 2.5,
            ),
          ],
        ),
        centerTitle: false,
      ),
      body:
          // Cards Display
          Column(
        children: [
          SizedBox(
            height: 150,
            child: InkWell(
              onTap: () {
                // Add the navigation code here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GameLobbyPage()),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(35.0), // Adjust the value as needed
                ),
                color: const Color.fromRGBO(255, 77, 77, 1),
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      height: 110,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/cc.jpg'),
                          fit: BoxFit.cover,
                          alignment: Alignment(.2, 0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Trivia",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          "Campus Center",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "14m until the next game",
                          style: TextStyle(
                            color: Color.fromRGBO(254, 213, 67, 1),
                            fontSize: 20,
                          ),
                        ),
                        Row(children: [
                          Image(
                            image: AssetImage('assets/person_icon.png'),
                          ),
                          Text(
                            "16 players waiting...",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ]),
                      ],
                    ),
                    Container(
                      width: 4,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
