import 'package:geolocation/geolocation.dart';
import 'dart:async';

class LocationTracking {
  static const LocationAccuracy ACCURACY = LocationAccuracy.best;

  ///we will be using location in the background
  static const BACKGROUND_USE = true;

  ///distance in meters between each Location updates
  static const DISPLACEMENT = 10.0;

  static const ANDROID_PERMISSION = LocationPermissionAndroid.fine;
  static const IOS_PERMISSION = LocationPermissionIOS.always;
  static const PERMISSION =
      LocationPermission(android: ANDROID_PERMISSION, ios: IOS_PERMISSION);

  int _subscriptionStartedTimestamp;
  StreamSubscription<LocationResult> _subscription;
  List<_LocationData> locations = [];

  _LocationData createLocationData(result){
    var seconds = new DateTime.now().millisecondsSinceEpoch - _subscriptionStartedTimestamp ~/ 1000;
    return new _LocationData(result: result, elapsedTimeSeconds: seconds);
  }

  onLocationData(result) {
    locations.insert(0, createLocationData(result));
  }

  dispose() {
    _subscription.cancel();
  }

  startRecordingLocation() {
    _subscription = Geolocation
        .locationUpdates(
            accuracy: ACCURACY,
            displacementFilter: DISPLACEMENT,
            inBackground: BACKGROUND_USE,
            permission: PERMISSION)
        .listen(onLocationData);

    _subscription.onDone(() {
      //TODO: add logic here when subscription is closed
    });
  }

  stopRecordingLocation() {
    _subscription.cancel();
    _subscription = null;
    _subscriptionStartedTimestamp = null;
  }

}

class _LocationData {
  _LocationData({
    this.result,
    this.elapsedTimeSeconds,
  });

  final LocationResult result;
  final int elapsedTimeSeconds;
}

LocationTracking locationTracking = new LocationTracking();
