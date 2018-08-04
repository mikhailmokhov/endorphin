import 'package:flutter/material.dart';

/// Enumerator for main views
enum Views { stat, run, settings }

enum VoiceStatModes { each_km_or_mile, each_five_km, each_five_minutes }

enum VoiceStatisticPeriodicity {
  each_1_measurement_unit,
  each_5_metric_units,
  each_5_minutes,
  each_10_minutes
}

class Activities {
  static const RUNNING_ID = 0;
  static const BIKING_ID = 1;
  static const HIKING_ID = 2;
  static const PUB_CRAWLING_ID = 3;

  static const Activity running =
      const Activity(RUNNING_ID, 'Running', 'Run', Icons.directions_run);

  static const Activity biking =
      const Activity(BIKING_ID, 'Biking', 'Bike', Icons.directions_bike);

  static const Activity hiking =
      const Activity(HIKING_ID, 'Hiking', 'Hike', Icons.directions_walk);

  static const Activity pubCrawling = const Activity(
      PUB_CRAWLING_ID, 'Pub crawling', 'Pub crawl', Icons.ev_station);

  static Activity getById(int id) {
    switch (id) {
      case RUNNING_ID:
        return running;
      case BIKING_ID:
        return biking;
      case HIKING_ID:
        return hiking;
      case PUB_CRAWLING_ID:
        return pubCrawling;
      default:
        return null;
    }
  }
}

class Activity {
  final int id;
  final pluralName;
  final singularName;
  final IconData iconData;

  const Activity(this.id, this.pluralName, this.singularName, this.iconData);
}

class TotalTime {
  String hours;
  String minutes;
  String seconds;
  final int milliseconds;

  TotalTime({this.hours, this.minutes, this.seconds})
      : this.milliseconds = null;

  TotalTime.fromMilliseconds(this.milliseconds) {
    Duration runDuration = Duration(milliseconds: this.milliseconds);
    int milliseconds = runDuration.inMilliseconds;
    this.hours = runDuration.inHours.toString();
    this.minutes =
        ((milliseconds / 60000).truncate() % 60).toString().padLeft(2, '0');
    seconds =
        ((milliseconds / 1000).truncate() % 60).toString().padLeft(2, '0');
  }
}

class Distance {
  final int distance;
  final MeasurementSystem measurement;
  int majorUnits;
  int minorUnits;
  double majorUnitsOnly;

  Distance(this.distance, this.measurement) {
    majorUnitsOnly = distance / measurement.majorUnitDivider;
    majorUnits = majorUnitsOnly.floor();
    minorUnits =
        ((distance - majorUnits * 1000) / measurement.minorUnitDivider).floor();
  }
}

class MeasurementSystems {
  static const KILOMETERS_ID = 0;
  static const MILES_ID = 1;
  static const VERSTS_ID = 2;
  static const MeasurementSystem kilometers = const MeasurementSystem(
      KILOMETERS_ID,
      'Kilometer',
      'Kilometers',
      'Meter',
      'Meters',
      'km',
      'm',
      1000.0,
      1.0);
  static const MeasurementSystem miles = const MeasurementSystem(
      MILES_ID, 'Miles', 'Mile', 'Yards', 'Yard', 'mi', 'yd', 1609.34, 0.9144);
  static const MeasurementSystem versts = const MeasurementSystem(
      VERSTS_ID,
      'Versts',
      'Verst',
      'Sazhens',
      'Sazhen',
      'verst',
      'sazhen',
      1066.8,
      1.0668);

  static MeasurementSystem getById(int id) {
    switch (id) {
      case KILOMETERS_ID:
        return kilometers;
      case MILES_ID:
        return miles;
      case VERSTS_ID:
        return miles;
      default:
        return null;
    }
  }
}

class MeasurementSystem {
  final int id;
  final String singularMajorUnitName;
  final String pluralMajorUnitName;
  final String singularMinorUnitName;
  final String pluralMinorUnitName;
  final String shortMajorUnitName;
  final String shortMinorUnitName;
  final double majorUnitDivider;
  final double minorUnitDivider;

  const MeasurementSystem(
      this.id,
      this.singularMajorUnitName,
      this.pluralMajorUnitName,
      this.singularMinorUnitName,
      this.pluralMinorUnitName,
      this.shortMajorUnitName,
      this.shortMinorUnitName,
      this.majorUnitDivider,
      this.minorUnitDivider);
}
