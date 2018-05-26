import 'package:flutter/material.dart';
import 'package:endorphin/running-page.dart';
import 'package:endorphin/geolocation-tracking.dart';
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

  _onDistanceChange(distance){
    setState((){
      meters = distance.floor();
      kilometers = (meters/1000).floor();
      meters = meters - kilometers * 1000;
    });
  }

  _DistanceTextState() {
    locationTracking.addLocationListener(_onDistanceChange);
  }
  @override
  dispose(){
    super.dispose();
    locationTracking.removeLocationListener(_onDistanceChange);
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
