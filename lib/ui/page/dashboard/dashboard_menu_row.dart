import 'package:eczakazanc/ui/widgets/label_below_icon.dart';
import 'package:flutter/material.dart';

class DashboardMenuRow extends StatelessWidget {
  final firstLabel;
  final IconData firstIcon;
  final firstIconCircleColor;
  final firstOnPressed;
  final secondLabel;
  final IconData secondIcon;
  final secondIconCircleColor;
  final secondOnPressed;
  final thirdLabel;
  final IconData thirdIcon;
  final thirdIconCircleColor;
  final thirdOnPressed;
  final fourthLabel;
  final IconData fourthIcon;
  final fourthIconCircleColor;
  final fourthOnPressed;

  const DashboardMenuRow(
      {Key key,
      this.firstLabel,
      this.firstIcon,
      this.firstIconCircleColor,
      this.firstOnPressed,
      this.secondLabel,
      this.secondIcon,
      this.secondIconCircleColor,
      this.secondOnPressed,
      this.thirdLabel,
      this.thirdIcon,
      this.thirdIconCircleColor,
      this.thirdOnPressed,
      this.fourthLabel,
      this.fourthIcon,
      this.fourthIconCircleColor,
      this.fourthOnPressed,})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          LabelBelowIcon(
            icon: firstIcon,
            onPressed: firstOnPressed,
            label: firstLabel,
            circleColor: firstIconCircleColor,
          ),
          LabelBelowIcon(
            icon: secondIcon,
            onPressed: secondOnPressed,
            label: secondLabel,
            circleColor: secondIconCircleColor,
          ),
          LabelBelowIcon(
            icon: thirdIcon,
            onPressed: thirdOnPressed,
            label: thirdLabel,
            circleColor: thirdIconCircleColor,
          ),
          LabelBelowIcon(
            icon: fourthIcon,
            onPressed: fourthOnPressed,
            label: fourthLabel,
            circleColor: fourthIconCircleColor,
          ),
        ],
      ),
    );
  }
}
