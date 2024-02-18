import 'package:cloud_firestore/cloud_firestore.dart';

class GameRoom {
  DocumentReference game;
  String instruction;
  String location;
  GeoPoint geoPoint;
  List<String> participants;
  Timestamp startTime;
  Timestamp endTime;

  GameRoom({
    required this.game,
    required this.instruction,
    required this.location,
    required this.geoPoint,
    required this.participants,
    required this.startTime,
    required this.endTime,
  });

  factory GameRoom.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return GameRoom(
      game: snapshot.reference,
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
    };
  }
}