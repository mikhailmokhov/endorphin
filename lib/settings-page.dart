import 'package:flutter/material.dart';
import 'package:endorphin/location-data-page.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsPageState createState() => new _SettingsPageState();
}

// At the top level:
enum Metric { kilometers, miles }

class _SettingsPageState extends State<SettingsPage> {
  // In the State of a stateful widget:
  Metric _metric = Metric.kilometers;
  bool _voiceStat = false;
  bool _startOnOpening = false;

  _openLocationsPage() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
            new LocationDataPage()));

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text(widget.title)),
        body: new ListView(
            addRepaintBoundaries: true,
            padding: new EdgeInsets.all(15.0),
            children: [
              new Column(children: [
                new RadioListTile(
                  title: const Text('Kilometers',
                      textAlign: TextAlign.left, textScaleFactor: 1.1),
                  value: Metric.kilometers,
                  groupValue: _metric,
                  onChanged: (Metric value) {
                    setState(() {
                      _metric = value;
                    });
                  },
                ),
                new RadioListTile(
                  title: const Text('Miles',
                      textAlign: TextAlign.left, textScaleFactor: 1.1),
                  value: Metric.miles,
                  groupValue: _metric,
                  onChanged: (Metric value) {
                    setState(() {
                      _metric = value;
                    });
                  },
                ),
              ]),
              new Row(),
              new Divider(),
              new Row(children: [
                new Expanded(
                    child: new Text('Start run on opening',
                        textScaleFactor: 1.6, textAlign: TextAlign.left)),
                new Switch(
                    value: _startOnOpening,
                    onChanged: (bool value) {
                      setState(() {
                        _startOnOpening = value;
                      });
                    })
              ]),
              Padding(
                  padding: new EdgeInsets.only(bottom: 7.0),
                  child: new Text(
                      'When enabled, the run starts automatically when the app is oppened')),
              new Divider(),
              new Row(children: [
                new Expanded(
                    child: new Text('Voice statistics',
                        textScaleFactor: 1.6, textAlign: TextAlign.left)),
                new Switch(
                    value: _voiceStat,
                    onChanged: (bool value) {
                      setState(() {
                        _voiceStat = value;
                      });
                    })
              ]),
              Padding(
                  padding: new EdgeInsets.only(bottom: 7.0),
                  child: new Text(
                      'When enabled, the app will be talking during run')),
              new Divider(),
              new Row(children: [
                new Expanded(
                    child: new FlatButton(
                        padding: new EdgeInsets.only(left: 0.0),
                        onPressed: _openLocationsPage,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              new Row(children: [
                                new Expanded(
                                    child: new Text("Location Data",
                                        style: new TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 22.0))),
                                new Icon(Icons.chevron_right,
                                    color: Colors.black54, size: 40.0)
                              ]),
                              new Row(children: [
                                Padding(
                                    padding: new EdgeInsets.only(bottom: 7.0),
                                    child: new Text(
                                        'Temporary page for debugging'))
                              ])
                            ]))),
              ]),
              new Divider()
            ]));
  }
}
