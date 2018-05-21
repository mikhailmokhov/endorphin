import 'package:flutter/material.dart';
import 'package:endorphin/settings-page.dart';
import 'package:endorphin/timer-text-widget.dart';
import 'dart:async';
import 'package:endorphin/main.dart';

bool paused = false;
Color statColor = Colors.black;
Stopwatch stopwatch = new Stopwatch();

class RunningPage extends StatefulWidget {
  RunningPage({Key key}) : super(key: key);

  @override
  _RunningPageState createState() => new _RunningPageState();
}

class _RunningPageState extends State<RunningPage> {
  var _pauseButtonLabel = "Pause";
  var _pauseButtonIcon = Icons.pause;
  var _title = "Running";

  _RunningPageState() {
    stopwatch.reset();
    stopwatch.start();
  }

  void _openSettings() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                new SettingsPage(title: "Settings")));
  }


  void _pause() {
    setState(() {
      paused = !paused;
      if (paused) {
        statColor = Colors.black12;
        _title = "Paused";
        _pauseButtonLabel = "Resume";
        _pauseButtonIcon = Icons.play_arrow;
        stopwatch.stop();
      } else {
        statColor = Colors.black;
        _title = "Running";
        _pauseButtonIcon = Icons.pause;
        _pauseButtonLabel = "Pause";
        stopwatch.start();
      }
    });
  }

  Future<Null> _neverSatisfied() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Finish this run?',style: new TextStyle(fontSize: 25.0)),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Yes', style: new TextStyle(fontSize: 25.0)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new MyHomePage()));
              },
            ),
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            automaticallyImplyLeading: false,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: new Text(_title),
            actions: <Widget>[
              new IconButton(
                  onPressed: _openSettings, icon: new Icon(Icons.settings))
            ]),
        body: new Container(
            padding: const EdgeInsets.all(22.0),
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Expanded(
                      child: new Column(children: [
                    new TimerText(),
                    new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Padding(
                              padding: new EdgeInsets.only(left: 5.0),
                              child: new Text("5",
                                  style: new TextStyle(
                                      fontSize: 36.0, color: statColor))),
                          new Text("km", style: new TextStyle(fontSize: 23.0, height: 1.6, color: statColor)),
                          new Padding(
                              padding: new EdgeInsets.only(left: 9.0),
                              child: new Text("350",
                                  style: new TextStyle(
                                      fontSize: 36.0, color: statColor))),
                          new Text("m", style: new TextStyle(fontSize: 23.0, height: 1.6, color: statColor))
                        ])
                  ])),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Expanded(
                          child: new FlatButton.icon(
                              onPressed: _pause,
                              icon: new Icon(_pauseButtonIcon),
                              label: new Text(_pauseButtonLabel,
                                  style: new TextStyle(fontSize: 26.0)))),
                      new Expanded(
                          child: new FlatButton.icon(
                              onPressed: _neverSatisfied,
                              icon: new Icon(Icons.flag),
                              label: new Text("Finish",
                                  style: new TextStyle(fontSize: 26.0))))
                    ],
                  )
                ])));
  }
}


