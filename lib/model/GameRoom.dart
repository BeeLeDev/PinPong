import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pinpong/model/Game.dart';

class GameRoom {
  DocumentReference<Map<String, dynamic>> game;
  String instruction;
  String location;
  GeoPoint geoPoint;
  List<String> participants;
  Timestamp startTime;
  Timestamp endTime;
  String name;

  GameRoom({
    required this.game,
    required this.instruction,
    required this.location,
    required this.geoPoint,
    required this.participants,
    required this.startTime,
    required this.endTime,
    required this.name,
  });

  factory GameRoom.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return GameRoom(
      game: data?['game'],
      instruction: data?['instruction'] ?? '',
      location: data?['location'] ?? '',
      geoPoint: data?['geoPoint'] != null
          ? GeoPoint(
        data?['geoPoint']['latitude'] ?? 0.0,
        data?['geoPoint']['longitude'] ?? 0.0,
      )
          : GeoPoint(0.0, 0.0),
      participants: data?['participants'] is Iterable
          ? List<String>.from(data?['participants'])
          : [],
      startTime: data?['startTime'],
      endTime: data?['endTime'],
      name: data?['name'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "game": game,
      "startTime": startTime,
      "endTime": endTime,
      "instruction": instruction,
      "location": location,
      "geoPoint": {
        "latitude": geoPoint.latitude,
        "longitude": geoPoint.longitude,
      },
      "participants": participants,
      "name" : name,
    };
  }
}