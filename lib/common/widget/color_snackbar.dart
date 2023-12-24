import 'package:flutter/material.dart';

class ColorSnackBar extends StatefulWidget {
  final String text;
  final Color? color;

  const ColorSnackBar({super.key, required this.text, required this.color});

  @override
  State<ColorSnackBar> createState() => _ColorSnackBarState();
}

class _ColorSnackBarState extends State<ColorSnackBar> {
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        widget.text,
        textAlign: TextAlign.center,
      ),
      backgroundColor: widget.color,
    );
  }
}
