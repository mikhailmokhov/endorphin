import 'package:endorphin/activity-class.dart';
import 'package:endorphin/settings-class.dart';
import 'package:flutter/material.dart';
import 'package:endorphin/timer-text-widget.dart';
import 'dart:async';
import 'geolocation-tracking.dart';
import 'package:endorphin/distance-text-widget.dart';

Stopwatch stopwatch = new Stopwatch();

class WorkoutWidget extends StatefulWidget {
  final Workout workout;
  final GeoLocationTracking tracking;
  final Settings settings;
  final VoidCallback onFinished;

  WorkoutWidget(
      {Key key,
      @required this.workout,
      @required this.tracking,
      @required this.settings,
      @required this.onFinished})
      : super(key: key);

  @override
  _WorkoutWidgetState createState() => new _WorkoutWidgetState();
}

class _WorkoutWidgetState extends State<WorkoutWidget> {

  void pause() {
    setState(() {
      widget.tracking.trackDistance = false;
      showPauseDialog().then((_) {
        setState(() {
          widget.tracking.trackDistance = true;
        });
      });
    });
  }

  Future finish() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Finish?', style: new TextStyle(fontSize: 25.0)),
          actions: <Widget>[
            new FlatButton(
                child: new Text('Yes', style: new TextStyle(fontSize: 25.0)),
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.workout.finish();
                  widget.workout.distance = widget.tracking.distance.toInt();
                  widget.onFinished();
                }),
            new FlatButton(
              child: new Text('No', style: new TextStyle(fontSize: 25.0)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Null> showPauseDialog() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Paused', style: new TextStyle(fontSize: 25.0)),
          content: new Text('Tap anywhere to proceed',
              style: new TextStyle(fontSize: 20.0)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          finish();
        },
        onTap: () {
          pause();
        },
        child: Container(
            color: widget.tracking.trackDistance
                ? Theme.of(context).scaffoldBackgroundColor
                : Colors.redAccent,
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 15.0),
                  child: new TimerText(widget.tracking.workout.startTime,
                      widget.tracking.trackDistance)),
              Padding(
                  padding: EdgeInsets.only(left: 17.0),
                  child: DistanceText(
                      locationTracking: widget.tracking,
                      measurementSystem: widget.settings.measurementSystem))
            ])));
  }
}
