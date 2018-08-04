import 'package:endorphin/settings-class.dart';
import 'package:flutter/material.dart';
import 'package:endorphin/common.dart';

class VoiceSettingsWidget extends StatefulWidget {
  final Settings settings;

  VoiceSettingsWidget(this.settings, {Key key}) : super(key: key);

  @override
  _VoiceSettingsState createState() => new _VoiceSettingsState();
}

class _VoiceSettingsState extends State<VoiceSettingsWidget> {
  BaseVoiceStatisticSettings settings;

  @override
  void initState() {
    switch (widget.settings.activityType) {
      case Activities.running:
        settings = widget.settings.runningVoiceStatisticSettings;
        break;
      case Activities.biking:
        settings = widget.settings.bikingVoiceStatisticSettings;
        break;
      case Activities.hiking:
        settings = widget.settings.hikingVoiceStatisticSettings;
        break;
      case Activities.pubCrawling:
        settings = widget.settings.pubCrawlingVoiceStatisticSettings;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new ListView(
            addRepaintBoundaries: true,
            padding: new EdgeInsets.all(15.0),
            children: [
          new Row(
              children: [Padding(padding: new EdgeInsets.only(bottom: 17.0))]),
          new Column(children: [
            new Row(children: [
              new GestureDetector(
                  child: Row(children: [
                    Icon(Icons.chevron_left, size: 40.0),
                    Icon(widget.settings.activityType .iconData)
                  ]),
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
              new Expanded(
                  child: new Text('Voice',
                      textScaleFactor: 1.6, textAlign: TextAlign.center)),
              new Switch(
                  value: settings.enabled,
                  onChanged: (bool value) {
                    setState(() {
                      settings.enabled = value;
                    });
                  })
            ]),
            new Divider(),
            new RadioListTile(
              title: Text(
                  'Each ' + widget.settings.measurementSystem.singularMajorUnitName,
                  textAlign: TextAlign.left,
                  textScaleFactor: 1.1),
              value: VoiceStatisticPeriodicity.each_1_measurement_unit,
              groupValue: settings.periodicity,
              onChanged: (VoiceStatisticPeriodicity value) {
                setState(() {
                  settings.periodicity = value;
                });
              },
            ),
            new RadioListTile(
              title: Text(
                  'Each 5 ' + widget.settings.measurementSystem.pluralMajorUnitName,
                  textAlign: TextAlign.left,
                  textScaleFactor: 1.1),
              value: VoiceStatisticPeriodicity.each_5_metric_units,
              groupValue: settings.periodicity,
              onChanged: (VoiceStatisticPeriodicity value) {
                setState(() {
                  settings.periodicity = value;
                });
              },
            ),
            new RadioListTile(
              title: Text('Each 5 minutes',
                  textAlign: TextAlign.left, textScaleFactor: 1.1),
              value: VoiceStatisticPeriodicity.each_5_minutes,
              groupValue: settings.periodicity,
              onChanged: (VoiceStatisticPeriodicity value) {
                setState(() {
                  settings.periodicity = value;
                });
              },
            ),
            new RadioListTile(
              title: Text('Each 10 minutes',
                  textAlign: TextAlign.left, textScaleFactor: 1.1),
              value: VoiceStatisticPeriodicity.each_10_minutes,
              groupValue: settings.periodicity,
              onChanged: (VoiceStatisticPeriodicity value) {
                setState(() {
                  settings.periodicity = value;
                });
              },
            )
          ]),
          new Divider()
        ]));
  }
}
