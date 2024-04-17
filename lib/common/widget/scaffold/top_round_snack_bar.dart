import 'package:flutter/material.dart';

class TopRoundSnackBar extends StatelessWidget {
  const TopRoundSnackBar({
    super.key,
    this.color,
    required this.text,
    this.textColor,
    required this.seconds,
  });

  final Color? color;
  final String text;
  final Color? textColor;
  final int seconds;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      backgroundColor: color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      duration: Duration(seconds: seconds),
    );
  }
}
