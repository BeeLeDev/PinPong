import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinpong/gameLobbyPage.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:pinpong/model/Location.dart';

final db = FirebaseFirestore.instance;
import 'package:pinpong/model/GameRoom.dart';
import 'package:pinpong/controller/FireStore.dart';
import 'dart:developer' as dev;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<GameRoom>> gameRooms() async {
    return await readGameRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Row(
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
      body: FutureBuilder<List<GameRoom>>(
        future: gameRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for the future to complete
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Display an error message if the future encountered an error
            return Text('Error: ${snapshot.error}');
          } else {
            // Display the data received from the future
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final gameRoom = snapshot.data![index];
                DateTime endTime = DateTime.fromMillisecondsSinceEpoch(
                    gameRoom.endTime.seconds * 1000);
                DateTime now = DateTime.now();
                Duration remaining = endTime.difference(now);
                String formattedRemaining =
                    "${remaining.inMinutes}m ${remaining.inSeconds % 60}s";

                return SizedBox(
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
                        borderRadius: BorderRadius.circular(
                            35.0), // Adjust the value as needed
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
                                image: AssetImage('assets/cc.jpg'),
                                fit: BoxFit.cover,
                                alignment: Alignment(.2, 0),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                gameRoom.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                gameRoom.location,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "$formattedRemaining until the next game",
                                style: const TextStyle(
                                  // Removed the `const` keyword here
                                  color: Color.fromRGBO(254, 213, 67, 1),
                                  fontSize: 16,
                                ),
                              ),
                              const Row(children: [
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
                );
              },
            );
          }
        },
      ),
    );
  }
}
