import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pinpong/gameLobbyPage.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:pinpong/model/Location.dart';

final db = FirebaseFirestore.instance;

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
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body:
          // Cards Display
          Column(
            children: [
            // Trivia Card
            SizedBox(
              height: 150,
              child: InkWell(
                onTap: () async {
                  var query = await db.collection('gamerooms').get();
                  var docs = query.docs[0].data();
                  var geoPoints = docs['geoPoint'];
                  var longitude = geoPoints['longitude'];
                  var latitude = geoPoints['latitude'];
                
                  // Add the navigation code here
                  if (await inRadius(latitude, longitude)) {
                    print("Passed");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GameLobbyPage()),
                    );
                  } else {
                    print("failed");
                    // Nothing
                  }
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

            // Treasure Hunting
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
                  color: const Color.fromRGBO(102, 77, 225, 1),
                  child: Row(
                    children: [
                      Container(
                        width: 150,
                        height: 110,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/wheatley.png'),
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
                            "Treasure Hunt",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            "Wheatley",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "2m until the next game",
                            style: TextStyle(
                              color: Color.fromRGBO(254, 213, 67, 1),
                              fontSize: 20,
                            ),
                          ),
                          Row(children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "You are ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "52 ft",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " away from this pin.",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )

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

            // Daily Quest
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Daily Quest",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Quest Card
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
                  color: const Color.fromRGBO(77, 180, 255, 1),
                  child: Row(
                    children: [
                      Container(
                        width: 150,
                        height: 110,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/chowoi.png'),
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
                            "Find Bak Choi",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            "Challenge: Fist Fight",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "2 hours remaining",
                            style: TextStyle(
                              color: Color.fromRGBO(254, 213, 67, 1),
                              fontSize: 20,
                            ),
                          ),
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
