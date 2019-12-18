import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:math';

class StarRating extends StatelessWidget {
  final int hedeflenen;
  final String talep;

  StarRating({this.hedeflenen = 0, this.talep = '0'});

  @override
  Widget build(BuildContext context) {
    print(talep);
    double yuzde = double.parse(talep) / 100;
    
    if (yuzde.isInfinite) {
      yuzde = 0;
    }
    int yuzdeInt = yuzde.toInt();
    String yuzdeDb = yuzdeInt.toStringAsFixed(1);
    double ddS = double.parse(yuzdeDb);
    return LinearPercentIndicator(
      width: 120.0,
      lineHeight: 5.0,
      percent: yuzde,
      backgroundColor: Colors.grey,
      progressColor: yuzde > 0.6
          ? Colors.red
          : ((yuzde < 0.3) ? Colors.green : Colors.blue),
    );
  }
}
