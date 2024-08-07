import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  const Line({
    super.key,
    this.color,
    this.height = 1,
    this.margin,
  });

  final Color? color;
  final EdgeInsets? margin;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      color: color ?? const Color.fromARGB(255, 228, 228, 228),
      height: height,
    );
  }
}
