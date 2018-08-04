import 'package:endorphin/activity-summary-widget.dart';
import 'package:endorphin/settings-class.dart';
import 'package:endorphin/settings-widget.dart';

//import 'package:endorphin/voice-generator-class.dart';
//import 'package:endorphin/voice-statistic-class.dart';
import 'package:flutter/material.dart';
import 'package:endorphin/workout-widget.dart';
import 'package:endorphin/activity-class.dart';
import 'package:endorphin/geolocation-tracking.dart';
import 'package:endorphin/common.dart';

void main() => runApp(EndorphinApp());

class EndorphinApp extends StatefulWidget {
  @override
  EndorphinState createState() => EndorphinState();
}

class EndorphinState extends State<EndorphinApp> {
  Settings settings;
  Views currentView;
  Workout workout;
  GeoLocationTracking _geolocationTracking;

  //VoiceGenerator _voiceGenerator;
  //VoiceStatistic _voiceStatistic;

  @override
  void initState() {
    super.initState();
    currentView = Views.run;
    //_voiceGenerator =  VoiceGenerator();
    //_voiceStatistic =  VoiceStatistic();
    settings = Settings();
    settings.loadFromSharedPreferences().then((settings) {
      if (settings.startOnOpening) {
        setState(() {
          _startActivity();
        });
      } else {
        setState(() {});
      }
    });
  }

  _startActivity() {
    workout = Workout(settings.activityType);
    _geolocationTracking = GeoLocationTracking(workout);
    _geolocationTracking.trackDistance = true;
    _geolocationTracking.startRecordingLocation();
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget;
    Brightness brightness;
    if (settings.darkTheme) {
      brightness = Brightness.dark;
    } else {
      brightness = Brightness.light;
    }
    var mainTheme = ThemeData(brightness: brightness);
    Activity activity = settings.activityType;
    switch (currentView) {
      case Views.stat:
        currentWidget = Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Text("There is no data", style: TextStyle(fontSize: 29.0))
            ]));
        break;
      case Views.run:
        if (workout == null) {
          currentWidget = Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Expanded(
                    child: FlatButton(
                        onPressed: () {
                          setState(() {
                            _startActivity();
                          });
                        },
                        child: Text("Tap anywhere to start",
                            style: TextStyle(fontSize: 29.0))))
              ]));
        } else if (workout.endTime == null) {
          currentWidget = WorkoutWidget(
              workout: workout,
              tracking: _geolocationTracking,
              settings: settings,
              onFinished: () {
                setState(() {});
              });
        } else {
          currentWidget = WorkoutSummary(workout: workout, settings: settings);
        }
        break;
      case Views.settings:
        currentWidget = SettingsWidget(
            settings: settings,
            onThemeChange: () {
              setState(() {});
            },
            onActivityChange: () {
              setState(() {});
            });
    }

    return MaterialApp(
      theme: mainTheme,
      home: Scaffold(
          body: currentWidget,
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (int index) {
                setState(() {
                  currentView = Views.values[index];
                });
              },
              currentIndex: currentView.index,
              items: [
                BottomNavigationBarItem(
                    title: Text('Stats'), icon: Icon(Icons.content_paste)),
                BottomNavigationBarItem(
                    icon: Icon(activity.iconData),
                    title: Text(workout != null
                        ? activity.pluralName
                        : activity.singularName)),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), title: Text('Settings'))
              ])),
    );
  }
}
