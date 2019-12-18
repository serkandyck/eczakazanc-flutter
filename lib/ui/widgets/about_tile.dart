import 'package:flutter/material.dart';
import 'package:eczakazanc/utils/uidata.dart';

class MyAboutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      applicationIcon: new ImageIcon(AssetImage(UIData.eczakazancImage)),
      icon: new ImageIcon(AssetImage(UIData.eczakazancImage)),
      aboutBoxChildren: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Developed By Serkan Dayıcık",
        ),
        Text(
          "Orbikey A.Ş",
        ),
      ],
      applicationName: UIData.appName,
      applicationVersion: "1.0.0",
      applicationLegalese: "Apache License 2.0",
    );
  }
}
