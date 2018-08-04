import 'package:flutter/material.dart';
import 'dart:async';

class TimerText extends StatefulWidget {
  final DateTime startTime;
  final bool active;

  TimerText(this.startTime, this.active, {Key key}) : super(key: key);

  @override
  _TimerTextState createState() => new _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
  Timer timer;
  String hours, minutes, seconds;

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 1000), timerCallback);
    _countTime();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    timer = null;
    super.dispose();
  }

  void timerCallback(Timer timer) {
    _countTime();
    setState(() {});
  }

  _countTime() {
    if(widget.active) {
      Duration runDuration = DateTime.now().difference(widget.startTime);
      int milliseconds = runDuration.inMilliseconds;
      hours = runDuration.inHours.toString();
      minutes =
          ((milliseconds / 60000).truncate() % 60).toString().padLeft(2, '0');
      seconds =
          ((milliseconds / 1000).truncate() % 60).toString().padLeft(2, '0');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle hoursMinutesTextStyle = TextStyle(fontSize: 90.0);
    TextStyle secondsTextStyle = TextStyle(fontSize: 50.0, height: 1.9);
    return Row(children: [
      Text(hours + ":" + minutes, style: hoursMinutesTextStyle),
      Text(":" + seconds, style: secondsTextStyle)
    ]);
  }
}
