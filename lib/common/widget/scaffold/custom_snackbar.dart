import 'package:flutter/material.dart';

class CustomSnackBar {
  CustomSnackBar._();

  static buildTopRoundedSnackBar(BuildContext context, String text,
      Color? color, Color? textColor, int seconds) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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
      ),
    );
  }
}
