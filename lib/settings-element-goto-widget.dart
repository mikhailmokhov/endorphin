import 'package:flutter/material.dart';

class SettingsElementGoToWidget extends StatelessWidget {
  final String titleText;
  final String descriptionText;
  final VoidCallback onTap;

  SettingsElementGoToWidget(
      {Key key,
      @required this.titleText,
      @required this.onTap,
      this.descriptionText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlatButton(
                  padding: EdgeInsets.only(left: 0.0),
                  onPressed: onTap,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(children: [
                          Expanded(
                              child: Text(titleText,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 22.0))),
                          Icon(Icons.chevron_right, size: 40.0)
                        ]),
                        Row(children: [
                          Padding(
                              padding: EdgeInsets.only(bottom: 7.0),
                              child: Text(descriptionText ?? ''))
                        ])
                      ]));

  }
}
