import 'package:flutter/material.dart';

class SizedIconButton extends StatelessWidget {
  const SizedIconButton(
      {super.key,
      required this.width,
      required this.icon,
      required this.onPressed});

  final double width;

  final IconData icon;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        onPressed: onPressed,
        child: Icon(icon),
      ),
    );
  }
}
