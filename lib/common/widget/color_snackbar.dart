import 'package:flutter/material.dart';

class ColorSnackBar extends StatelessWidget {
  final String text;
  final Color? color;

  const ColorSnackBar({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
    );
  }
}
