import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:pinpong/model/Location.dart';

final db = FirebaseFirestore.instance;

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.

  Position position = await Geolocator.getCurrentPosition();
  return position;
}

// Global Radius
const EarthRadius = 6371000; // 6378100;
const Radius = 900;

Map calculate(double latitude, double longtitude) {
  double latRadians = latitude * pi / 180;
  double lonRadians = longtitude * pi / 180;
  double angularDistance = Radius / EarthRadius;

  double minLat = latRadians - angularDistance;
  double maxLat = latRadians + angularDistance;

  double deltaLon = asin(sin(angularDistance) / cos(latRadians));

  double minLon = lonRadians - deltaLon;
  double maxLon = lonRadians + deltaLon;

  double updatedMinLat = minLat * 180 / pi;
  double updatedMinLon = minLon * 180 / pi;
  double updatedMaxLat = maxLat * 180 / pi;
  double updatedMaxLon = maxLon * 180 / pi;

  double MinLat = updatedMinLat;
  double MaxLat = updatedMaxLat;
  double MinLon = updatedMinLon;
  double MaxLon = updatedMaxLon;

  return {'MinLat': MinLat, 'MaxLat':  MaxLat, 'MinLon': MinLon, 'MaxLon': MaxLon};
}

Future<bool> inRadius(double locLat, double locLong) async {
  Map calculatedPoints = calculate(locLat, locLong);
  Position position = await Geolocator.getCurrentPosition();

  var latitude = position.latitude;
  var longitude = position.longitude;

  print('${calculatedPoints['MinLat']} $latitude ${calculatedPoints['MaxLat']}');
  print('${calculatedPoints['MinLon']} $longitude ${calculatedPoints['MaxLon']}');

  if (calculatedPoints['MinLat'] < latitude && latitude < calculatedPoints['MaxLat'] &&
    (calculatedPoints['MinLon'] < longitude && longitude < calculatedPoints['MaxLon'])) {
      print("inradius true");
      return true;
    } else {
      print("inradius false");
      return false;
    }
}