import 'package:geolocation/geolocation.dart';
import 'dart:async';
import 'package:latlong/latlong.dart';

class LocationTracking {
  static const LocationAccuracy ACCURACY = LocationAccuracy.best;

  ///we will be using location in the background
  static const BACKGROUND_USE = true;

  ///distance in meters between each Location updates
  static const DISPLACEMENT = 5.0;

  static const ANDROID_PERMISSION = LocationPermissionAndroid.fine;
  static const IOS_PERMISSION = LocationPermissionIOS.always;
  static const PERMISSION =
      LocationPermission(android: ANDROID_PERMISSION, ios: IOS_PERMISSION);

  int _subscriptionStartedTimestamp;
  StreamSubscription<LocationResult> _subscription;
  List<LocationData> locations = [];
  bool _isTracking = false;
  double distance = 0.0;
  final Distance distanceCalculator = new Distance();


  LocationData createLocationData(result) {
    var millisecondsNow = new DateTime.now().millisecondsSinceEpoch;
    var seconds = (millisecondsNow - _subscriptionStartedTimestamp) ~/ 1000;
    return new LocationData(result: result, elapsedTimeSeconds: seconds);
  }

  _updateDistance(LocationResult result1, LocationResult result2) {
    if (result1.isSuccessful && result2.isSuccessful) {
      double segmentMeters = distanceCalculator(
          new LatLng(result1.location.latitude,result1.location.longitude),
          new LatLng(result2.location.latitude,result2.location.longitude)
      );
      distance = distance + segmentMeters;
    }
  }

  onLocationData(LocationResult result) {
    if(locations.length>0) {
      _updateDistance(result, locations[0].result);
    }
    locations.insert(0, createLocationData(result));
  }

  dispose() {
    _subscription.cancel();
  }

  isTracking() {
    return _isTracking;
  }


  startRecordingLocation() {
    distance = 0.0;
    _subscriptionStartedTimestamp = new DateTime.now().millisecondsSinceEpoch;
    locations = [];
    _subscription = Geolocation
        .locationUpdates(
            accuracy: ACCURACY,
            displacementFilter: DISPLACEMENT,
            inBackground: BACKGROUND_USE,
            permission: PERMISSION)
        .listen(onLocationData);
    _isTracking = true;
    _subscription.onDone(() {
      _isTracking = false;
      //TODO: add logic here when subscription is closed
    });
  }

  stopRecordingLocation() {
    _subscription.cancel();
    _subscription = null;
    _subscriptionStartedTimestamp = null;
    _isTracking = false;
  }
}

class LocationData {
  LocationData({
    this.result,
    this.elapsedTimeSeconds,
  });

  final LocationResult result;
  final int elapsedTimeSeconds;
}

LocationTracking locationTracking = new LocationTracking();
