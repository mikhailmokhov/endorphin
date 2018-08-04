import 'package:endorphin/common.dart';
import 'package:endorphin/settings-class.dart';
import 'package:endorphin/settings-element-goto-widget.dart';
import 'package:endorphin/voice-settings-widget.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  final Settings settings;
  final VoidCallback onThemeChange;
  final VoidCallback onActivityChange;

  const SettingsWidget(
      {Key key,
      @required this.settings,
      @required this.onThemeChange,
      @required this.onActivityChange})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: ListView(
            addRepaintBoundaries: true,
            padding: EdgeInsets.all(15.0),
            children: [
          Row(children: [Padding(padding: EdgeInsets.only(bottom: 17.0))]),
          Column(children: [
            Row(children: [
              Expanded(
                  child: Text('Dark theme',
                      textScaleFactor: 1.6, textAlign: TextAlign.left)),
              Switch(
                  value: widget.settings.darkTheme,
                  onChanged: (bool value) {
                    widget.settings.darkTheme = value;
                    widget.onThemeChange();
                  })
            ]),
            Divider(),
            SettingsElementGoToWidget(
                titleText: "Voice statistic",
                descriptionText:
                    'Sets settings individually for each activity type',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            VoiceSettingsWidget(widget.settings)),
                  );
                }),
            Divider(),
            RadioListTile(
              title: Text(Activities.running.pluralName,
                  textAlign: TextAlign.left, textScaleFactor: 1.1),
              secondary: Icon(Activities.running.iconData,
                  size: widget.settings.activityType == Activities.running
                      ? IconTheme.of(context).size * 1.1
                      : IconTheme.of(context).size),
              selected: widget.settings.activityType == Activities.running,
              value: Activities.running,
              groupValue: widget.settings.activityType,
              onChanged: (Activity value) {
                widget.settings.activityType = value;

                widget.onActivityChange();
              },
            ),
            RadioListTile(
              title: Text(Activities.biking.pluralName,
                  textAlign: TextAlign.left, textScaleFactor: 1.1),
              secondary: Icon(Activities.biking.iconData,
                  size: widget.settings.activityType == Activities.biking
                      ? IconTheme.of(context).size * 1.1
                      : IconTheme.of(context).size),
              selected: widget.settings.activityType == Activities.biking,
              value: Activities.biking,
              groupValue: widget.settings.activityType,
              onChanged: (Activity value) {
                widget.settings.activityType = value;

                widget.onActivityChange();
              },
            ),
            RadioListTile(
              title: Text(Activities.hiking.pluralName,
                  textAlign: TextAlign.left, textScaleFactor: 1.1),
              secondary: Icon(Activities.hiking.iconData,
                  size: widget.settings.activityType == Activities.hiking
                      ? IconTheme.of(context).size * 1.1
                      : IconTheme.of(context).size),
              selected: widget.settings.activityType == Activities.hiking,
              value: Activities.hiking,
              groupValue: widget.settings.activityType,
              onChanged: (Activity value) {
                widget.settings.activityType = value;

                widget.onActivityChange();
              },
            ),
            RadioListTile(
              title: Text(Activities.pubCrawling.pluralName,
                  textAlign: TextAlign.left, textScaleFactor: 1.1),
              secondary: Icon(Activities.pubCrawling.iconData,
                  size: widget.settings.activityType == Activities.pubCrawling
                      ? IconTheme.of(context).size * 1.1
                      : IconTheme.of(context).size),
              selected: widget.settings.activityType == Activities.pubCrawling,
              value: Activities.pubCrawling,
              groupValue: widget.settings.activityType,
              onChanged: (Activity value) {
                widget.settings.activityType = value;

                widget.onActivityChange();
              },
            )
          ]),
          Divider(),
          Row(children: [
            Expanded(
                child: Text('Start on opening',
                    textScaleFactor: 1.6, textAlign: TextAlign.left)),
            Switch(
                value: widget.settings.startOnOpening,
                onChanged: (bool value) {
                  setState(() {
                    widget.settings.startOnOpening = value;
                  });
                })
          ]),
          Padding(
              padding: EdgeInsets.only(bottom: 7.0),
              child: Text(
                  'When enabled activity starts automatically on app launch')),
          Divider(),
          SettingsElementGoToWidget(
              titleText: "Location Data",
              descriptionText: 'Temporary page for debugging',
              onTap: () {}),
          Divider(),
          Column(children: [
            RadioListTile(
              title: const Text('Kilometers',
                  textAlign: TextAlign.left, textScaleFactor: 1.1),
              value: MeasurementSystems.kilometers,
              groupValue: widget.settings.measurementSystem,
              onChanged: (MeasurementSystem value) {
                setState(() {
                  widget.settings.measurementSystem = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Miles',
                  textAlign: TextAlign.left, textScaleFactor: 1.1),
              value: MeasurementSystems.miles,
              groupValue: widget.settings.measurementSystem,
              onChanged: (MeasurementSystem value) {
                setState(() {
                  widget.settings.measurementSystem = value;
                });
              },
            ),
            RadioListTile(
              title: const Text('Versts',
                  textAlign: TextAlign.left, textScaleFactor: 1.1),
              value: MeasurementSystems.versts,
              groupValue: widget.settings.measurementSystem,
              onChanged: (MeasurementSystem value) {
                setState(() {
                  widget.settings.measurementSystem = value;
                });
              },
            ),
          ]),
          Divider(),
        ]));
  }
}
