import 'package:uuid/uuid.dart';
import 'location-data-class.dart';
import 'dart:convert';
import 'package:endorphin/common.dart';

class Workout {
  final String uuid;
  final Activity type;
  final DateTime startTime;
  DateTime endTime;
  List<LocationData> locationRecords;
  int totalTime;
  int distance;

  Workout(this.type)
      : uuid = (new Uuid()).v1(),
        locationRecords = new List(),
        startTime = new DateTime.now();

  Workout.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        startTime = json['startTime'],
        endTime = json['endTime'],
        locationRecords = json['locationRecords'],
        type = json['type'];

  toJson() => json.encode(this);

  addLocation(LocationData location) {
    this.locationRecords.add(location);
  }

  finish() {
    this.endTime = new DateTime.now();
    this.totalTime = this.endTime.difference(this.startTime).inMilliseconds;
  }
}
