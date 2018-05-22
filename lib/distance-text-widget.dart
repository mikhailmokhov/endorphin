import 'package:flutter/material.dart';
import 'package:endorphin/running-page.dart';
import 'package:endorphin/location-tracking.dart';
import 'dart:async';

class DistanceText extends StatefulWidget {
  DistanceText({Key key}) : super(key: key);

  @override
  _DistanceTextState createState() => new _DistanceTextState();
}

class _DistanceTextState extends State<DistanceText> {
  Timer timer;

  int kilometers = 0;
  int meters = 0;

  _DistanceTextState() {
    timer = new Timer.periodic(new Duration(milliseconds: 50), callback);
  }

  void callback(Timer timer) {
    if (locationTracking.isTracking()) {
      setState(() {
        meters = locationTracking.distance.floor();
        kilometers = (meters/1000).floor();
        meters = meters - kilometers * 1000;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return new Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      new Padding(
          padding: new EdgeInsets.only(left: 5.0),
          child: new Text(kilometers.toString(),
              style: new TextStyle(fontSize: 36.0, color: statColor))),
      new Text("km",
          style: new TextStyle(fontSize: 23.0, height: 1.6, color: statColor)),
      new Padding(
          padding: new EdgeInsets.only(left: 9.0),
          child: new Text(meters.toString(),
              style: new TextStyle(fontSize: 36.0, color: statColor))),
      new Text("m",
          style: new TextStyle(fontSize: 23.0, height: 1.6, color: statColor))
    ]);
  }
}

class TimerTextFormatter {
  static String getHoursMinutes(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString();
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr";
  }

  static String getSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return ":$secondsStr";
  }
}
