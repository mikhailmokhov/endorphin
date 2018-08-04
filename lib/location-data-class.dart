import 'package:geolocation/geolocation.dart';

class LocationData {
  LocationData({
    this.result,
    this.elapsedTimeSeconds,
  });

  final LocationResult result;
  final int elapsedTimeSeconds;
}