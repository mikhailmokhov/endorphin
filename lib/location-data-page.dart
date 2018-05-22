import 'package:flutter/material.dart';
import 'package:endorphin/location-tracking.dart';
import 'package:geolocation/geolocation.dart';

class LocationDataPage extends StatefulWidget {
  @override
  _LocationDataState createState() => new _LocationDataState();
}

class _LocationDataState extends State<LocationDataPage> {

  bool _isRecordingLocationData = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      new _Header(
        isRecordingLocationData: _isRecordingLocationData
      )
    ];

    children.addAll(ListTile.divideTiles(
      context: context,
      tiles: locationTracking.locations.map((location) => new _Item(data: location)).toList(),
    ));

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Location updates'),
      ),
      body: new ListView(
        children: children,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  _Header({this.isRecordingLocationData});

  final bool isRecordingLocationData;

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: new Text('Is recording: ' + locationTracking.isTracking().toString()),
    );
  }
}

class _Item extends StatelessWidget {
  _Item({this.data});

  final LocationData data;

  @override
  Widget build(BuildContext context) {
    String text;
    String status;
    Color color;

    if (data.result.isSuccessful) {
      text =
      'Lat: ${data.result.location.latitude} - Lng: ${data.result.location
          .longitude}';
      status = 'success';
      color = Colors.green;
    } else {
      switch (data.result.error.type) {
        case GeolocationResultErrorType.runtime:
          text = 'Failure: ${data.result.error.message}';
          break;
        case GeolocationResultErrorType.locationNotFound:
          text = 'Location not found';
          break;
        case GeolocationResultErrorType.serviceDisabled:
          text = 'Service disabled';
          break;
        case GeolocationResultErrorType.permissionDenied:
          text = 'Permission denied';
          break;
        case GeolocationResultErrorType.playServicesUnavailable:
          text =
          'Play services unavailable: ${data.result.error.additionalInfo}';
          break;
      }

      status = 'failure';
      color = Colors.red;
    }

    final List<Widget> content = <Widget>[
      new Text(
        text,
        style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      new SizedBox(
        height: 3.0,
      ),
      new Text(
        'Elapsed time: ${data.elapsedTimeSeconds == 0 ? '< 1' : data
            .elapsedTimeSeconds}s',
        style: const TextStyle(fontSize: 12.0, color: Colors.grey),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ];

    return new Container(
      color: Colors.white,
      child: new SizedBox(
        height: 56.0,
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: content,
                ),
              ),
              new Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: new BoxDecoration(
                  color: color,
                  borderRadius: new BorderRadius.circular(6.0),
                ),
                child: new Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

