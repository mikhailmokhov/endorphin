import 'package:location/location.dart';
import 'package:latlong/latlong.dart';
import 'dart:async';

class LocationTracking {
  StreamSubscription<Map<String, double>> _locationSubscription;

  Location _location = new Location();

}