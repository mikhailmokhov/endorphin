import 'package:flutter/material.dart';
import 'package:endorphin/running-page.dart';
import 'dart:async';

class TimerText extends StatefulWidget {
  TimerText({Key key}) : super(key: key);

  @override
  _TimerTextState createState() => new _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
  Timer timer;

  _TimerTextState() {
    timer = new Timer.periodic(new Duration(milliseconds: 1000), callback);
  }

  void callback(Timer timer) {
    if (stopwatch.isRunning) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle hoursMinutesTextStyle =
        new TextStyle(fontSize: 90.0, color: statColor);
    TextStyle secondsTextStyle =
        new TextStyle(fontSize: 50.0, color: statColor, height: 1.9);
    String hoursMinutes =
        TimerTextFormatter.getHoursMinutes(stopwatch.elapsedMilliseconds);
    String seconds =
        TimerTextFormatter.getSeconds(stopwatch.elapsedMilliseconds);
    return new Row(children: [
      new Text(hoursMinutes, style: hoursMinutesTextStyle),
      new Text(seconds, style: secondsTextStyle)
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
