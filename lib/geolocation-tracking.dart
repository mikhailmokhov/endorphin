import 'package:geolocation/geolocation.dart';
import 'dart:async';
import 'package:latlong/latlong.dart';

class GeoLocationTracking {
  static const LocationAccuracy ACCURACY = LocationAccuracy.best;

  ///we will be using location in the background
  static const BACKGROUND_USE = true;

  ///distance in meters between each Location updates
  static const DISPLACEMENT = 1.0;

  ///First location measurements are usually very inaccurate, because
  ///device location service just started, we will skip measuring distance for
  ///the following number of the first location results.
  ///Note, that they will still be added to the locations array.
  static const SKIP_FIRST_MEASUREMENTS = 0;

  static const ANDROID_PERMISSION = LocationPermissionAndroid.fine;
  static const IOS_PERMISSION = LocationPermissionIOS.always;
  static const PERMISSION =
      LocationPermission(android: ANDROID_PERMISSION, ios: IOS_PERMISSION);

  int _subscriptionStartedTimestamp;
  StreamSubscription<LocationResult> _subscription;
  List<LocationData> locations = [];
  LocationData lastLocation;
  bool trackDistance = false;
  bool isTrackingLocation = false;
  double distance = 0.0;
  List<Function> _locationListeners = [];
  final Distance distanceCalculator = new Distance();

  GeoLocationTracking(){
    startRecordingLocation();
  }

  LocationData createLocationData(result) {
    var millisecondsNow = new DateTime.now().millisecondsSinceEpoch;
    var seconds = (millisecondsNow - _subscriptionStartedTimestamp) ~/ 1000;
    return new LocationData(result: result, elapsedTimeSeconds: seconds);
  }

  _updateDistance(LocationResult result1, LocationResult result2) {
    if (trackDistance && result1.isSuccessful && result2.isSuccessful) {
      double segmentMeters = distanceCalculator(
          new LatLng(result1.location.latitude,result1.location.longitude),
          new LatLng(result2.location.latitude,result2.location.longitude)
      );
      distance = distance + segmentMeters;
    }
  }

  onLocationData(LocationResult result) {
    if(lastLocation != null ) {
      _updateDistance(result, lastLocation.result);
    }
    lastLocation = createLocationData(result);
    for (var i = 0; i < _locationListeners.length; i++) {
      if(_locationListeners[i] is Function){
        _locationListeners[i](distance);
      } else {
        _locationListeners.removeAt(i);
      }
    }
  }

  dispose() {
    _subscription.cancel();
  }

  addLocationListener(Function callback){
    if(_locationListeners.indexOf(callback) == -1){
      _locationListeners.add(callback);
    }
  }

  removeLocationListener(Function callback){
    _locationListeners.remove(callback);
  }

  startRecordingLocation() {
    distance = 0.0;
    _subscriptionStartedTimestamp = new DateTime.now().millisecondsSinceEpoch;
    locations = [];
    _subscription = Geolocation
        .locationUpdates(
            accuracy: ACCURACY,
            inBackground: BACKGROUND_USE,
            permission: PERMISSION)
        .listen(onLocationData);
     isTrackingLocation = true;
    _subscription.onDone(() {
       isTrackingLocation = false;
      //TODO: add logic here when subscription is closed
    });
  }

  stopRecordingLocation() {
    _subscription.cancel();
    _subscription = null;
    _subscriptionStartedTimestamp = null;
     isTrackingLocation = false;
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

GeoLocationTracking locationTracking = new GeoLocationTracking();
