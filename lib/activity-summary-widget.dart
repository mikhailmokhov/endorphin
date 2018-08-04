import 'package:endorphin/activity-class.dart';
import 'package:endorphin/common.dart';
import 'package:endorphin/settings-class.dart';
import 'package:flutter/material.dart';

class WorkoutSummary extends StatelessWidget {
  final Workout workout;
  final TotalTime totalTime;
  final Settings settings;

  WorkoutSummary({Key key, @required this.workout, @required this.settings})
      : totalTime = TotalTime.fromMilliseconds(workout.totalTime),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
        margin: const EdgeInsets.fromLTRB(20.0, 40.0, 0.0, 0.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text('Time: ' +
              totalTime.hours +
              ':' +
              totalTime.minutes +
              ':' +
              totalTime.seconds, textScaleFactor: 3.0),
          Text('Distance: ' + workout.distance.toString(),
              textScaleFactor: 2.0)
        ]));
  }
}
