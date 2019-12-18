import 'package:flutter/material.dart';
import 'package:eczakazanc/eczakazanc.dart';
import 'package:flutter/services.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(new EczaKazanc());
}
