import 'package:flutter/cupertino.dart';
import 'package:endorphin/settings-page.dart';
import 'package:endorphin/running-page.dart';
import 'package:flutter/material.dart';
import 'package:endorphin/main-theme.dart';
import 'package:endorphin/location-tracking.dart';

void main() => runApp(new MyApp());



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Endorphin',
      theme: mainTheme,
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Endorphin";

  @override
  _MyHomePageState createState() {
    return new _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  void _openSettings() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                new SettingsPage(title: "Settings")));
  }

  void _startRun() {

    locationTracking.startRecordingLocation();


    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new RunningPage()));
    // This call to setState tells the Flutter framework that something has
    // changed in this State, which causes it to rerun the build method below
    // so that the display can reflect the updated values. If we changed
    // _counter without calling setState(), then the build method would not be
    // called again, and so nothing would appear to happen.
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
        appBar: new AppBar(
            automaticallyImplyLeading: false,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: new Text(widget.title),
            actions: <Widget>[
              new IconButton(
                  onPressed: _openSettings, icon: new Icon(Icons.settings))
            ]),
        body: new Container(
          child: new Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                new FlatButton(
                    onPressed: _startRun,
                    child:
                        new Text("Start", style: new TextStyle(fontSize: 29.0)))
              ])) /* add child content content here */,
        ));
  }
}
