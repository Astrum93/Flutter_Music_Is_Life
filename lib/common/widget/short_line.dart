import 'package:flutter/material.dart';

class ShortLine extends StatelessWidget {
  const ShortLine({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: 100,
      height: 2,
    );
  }
}
