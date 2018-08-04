import 'package:endorphin/geolocation-tracking.dart';
import 'package:flutter/material.dart';
import 'package:endorphin/common.dart';

class DistanceText extends StatefulWidget {
  final GeoLocationTracking locationTracking;
  final MeasurementSystem measurementSystem;


  DistanceText({Key key, @required GeoLocationTracking locationTracking, @required measurementSystem})
      : locationTracking = locationTracking,
        measurementSystem = measurementSystem,
        super(key: key);

  @override
  _DistanceTextState createState() => _DistanceTextState(locationTracking);
}

class _DistanceTextState extends State<DistanceText> {
  GeoLocationTracking location;
  int meters = 0;
  int kilometers = 0;

  _callback(distance){
    _calculateDistance(distance);
    setState(() { });
  }

  _calculateDistance(distance){
    meters = distance.floor();
    kilometers = (meters / 1000).floor();
    meters = meters - kilometers * 1000;
  }

  _DistanceTextState(this.location){
    _calculateDistance(location.distance);
    location.addLocationListener(_callback);
  }

  @override
  void dispose() {
    location.removeLocationListener(_callback);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets;
    if (widget.measurementSystem == MeasurementSystems.kilometers) {
      widgets = [

        Padding(
            padding:  EdgeInsets.only(left: 5.0),
            child:  Text(kilometers.toString(),
                style:  TextStyle(fontSize: 36.0))),
        Text("km", style:  TextStyle(fontSize: 23.0, height: 1.6)),
        Padding(
            padding:  EdgeInsets.only(left: 9.0),
            child:  Text(meters.toString(),
                style:  TextStyle(fontSize: 36.0))),
        Text("m", style:  TextStyle(fontSize: 23.0, height: 1.6))
      ];
    } else {
      double miles = widget.locationTracking.distance / 1609.344;
      widgets = [
        Padding(
            padding:  EdgeInsets.only(left: 5.0),
            child:  Icon(Icons.directions)),
        Padding(
          padding:  EdgeInsets.only(left: 5.0),
          child:  Text(miles.toStringAsPrecision(1),
              style:  TextStyle(fontSize: 36.0))),
      Text("miles", style:  TextStyle(fontSize: 23.0, height: 1.6))];
    }

    return Row( children: widgets);
  }
}

