import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:endorphin/common.dart';

class BaseSettings {
  static SharedPreferences preferences;

  static Future<SharedPreferences> getPreferences() {
    Completer<SharedPreferences> completer = Completer();
    if (preferences is SharedPreferences) {
      completer.complete(preferences);
    } else {
      SharedPreferences.getInstance().then((instance) {
        preferences = instance;
        completer.complete(preferences);
      });
    }
    return completer.future;
  }

  static saveSetting(String key, dynamic value) {
    assert(key is String);
    assert(value is bool || value is int || value is String);
    getPreferences().then((preferences) {
      if (value is bool) {
        preferences.setBool(key, value);
      } else if (value is int) {
        preferences.setInt(key, value);
      } else if (value is String) {
        preferences.setString(key, value);
      }
    });
  }
}

class Settings extends BaseSettings {
  Activity _activityType;
  MeasurementSystem _measurementSystem;
  bool _voiceStat;
  bool _startOnOpening;
  bool _darkTheme;
  RunningVoiceStatisticSettings runningVoiceStatisticSettings;
  BikingVoiceStatisticSettings bikingVoiceStatisticSettings;
  HikingVoiceStatisticSettings hikingVoiceStatisticSettings;
  PubCrawlingVoiceStatisticSettings pubCrawlingVoiceStatisticSettings;

  Settings() {
    // Set default values.
    // We need them to let app proceed working before settings are loaded from
    // disk using loadFromSharedPreferences.
    this._darkTheme = false;
    this._activityType = Activities.running;
    this._measurementSystem = MeasurementSystems.kilometers;
    this._voiceStat = voiceStat;
    this._startOnOpening = false;
    // In case the voice statistic settings are going to be different lets use
    // separate classes for each activity.
    this.runningVoiceStatisticSettings = new RunningVoiceStatisticSettings();
    this.bikingVoiceStatisticSettings = new BikingVoiceStatisticSettings();
    this.hikingVoiceStatisticSettings = new HikingVoiceStatisticSettings();
    this.pubCrawlingVoiceStatisticSettings =
        new PubCrawlingVoiceStatisticSettings();
  }

  Future<Settings> loadFromSharedPreferences() {
    return BaseSettings.getPreferences().then((preferences) {
      this._measurementSystem = MeasurementSystems.getById(
          preferences.getString('measurement_system') ??
              this._measurementSystem.id);
      this._activityType = Activities.getById(
          preferences.getInt('activity_type') ?? this._activityType.id);
      this._startOnOpening =
          preferences.getBool('start_on_opening') ?? startOnOpening;
      this._voiceStat =
          preferences.getBool('voice_statistic_enabled') ?? this.voiceStat;
      this._darkTheme = preferences.getBool('dark_theme') ?? this._darkTheme;
      this.runningVoiceStatisticSettings.loadFromSharedPreferences(preferences);
      this.bikingVoiceStatisticSettings.loadFromSharedPreferences(preferences);
      this.hikingVoiceStatisticSettings.loadFromSharedPreferences(preferences);
      this
          .pubCrawlingVoiceStatisticSettings
          .loadFromSharedPreferences(preferences);
      return this;
    });
  }

  Activity get activityType => _activityType;

  set activityType(Activity value) {
    _activityType = value;
    BaseSettings.saveSetting('activity_type', value.id);
  }

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    BaseSettings.saveSetting('dark_theme', value);
  }

  MeasurementSystem get measurementSystem => _measurementSystem;

  set measurementSystem(MeasurementSystem value) {
    _measurementSystem = value;
    BaseSettings.saveSetting('measurement_system', _measurementSystem.id);
  }

  bool get voiceStat => _voiceStat;

  set voiceStat(bool value) {
    _voiceStat = value;
    BaseSettings.saveSetting('voice_statistic_enabled', value);
  }

  bool get startOnOpening => _startOnOpening;

  set startOnOpening(bool value) {
    _startOnOpening = value;
    BaseSettings.saveSetting('start_on_opening', value);
  }
}

class BaseVoiceStatisticSettings extends BaseSettings {
  bool _enabled;
  VoiceStatisticPeriodicity _periodicity;
  String _activityKey;
  String name;

  void loadFromSharedPreferences(preferences) {
    this._periodicity = VoiceStatisticPeriodicity.values[preferences
            .getInt(this._activityKey + '_voice_statistic_periodicity') ??
        this._periodicity.index];
    this._enabled =
        preferences.getBool(this._activityKey + '_voice_statistic_enabled') ??
            this._enabled;
  }

  bool get enabled => _enabled;

  set enabled(bool value) {
    _enabled = value;
    BaseSettings.saveSetting(
        this._activityKey + '_voice_statistic_enabled', value);
  }

  VoiceStatisticPeriodicity get periodicity => _periodicity;

  set periodicity(VoiceStatisticPeriodicity value) {
    _periodicity = value;
    BaseSettings.saveSetting(
        this._activityKey + '_voice_statistic_periodicity', value.index);
  }
}

class RunningVoiceStatisticSettings extends BaseVoiceStatisticSettings {
  RunningVoiceStatisticSettings() {
    this._activityKey = 'running';
    this.name = 'Running';
    // Default values
    this._enabled = false;
    this._periodicity = VoiceStatisticPeriodicity.each_1_measurement_unit;
  }
}

class BikingVoiceStatisticSettings extends BaseVoiceStatisticSettings {
  BikingVoiceStatisticSettings() {
    this._activityKey = 'biking';
    this.name = 'Biking';
    // Default values
    this._enabled = false;
    this._periodicity = VoiceStatisticPeriodicity.each_5_minutes;
  }
}

class HikingVoiceStatisticSettings extends BaseVoiceStatisticSettings {
  HikingVoiceStatisticSettings() {
    this._activityKey = 'hiking';
    this.name = 'Hiking';
    // Default values
    this._enabled = false;
    this._periodicity = VoiceStatisticPeriodicity.each_10_minutes;
  }
}

class PubCrawlingVoiceStatisticSettings extends BaseVoiceStatisticSettings {
  PubCrawlingVoiceStatisticSettings() {
    this.name = 'Pub Crawling';
    this._activityKey = 'pub_crawling';
    // Default values
    this._enabled = false;
    this._periodicity = VoiceStatisticPeriodicity.each_10_minutes;
  }
}
