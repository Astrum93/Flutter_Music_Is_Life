import 'package:flutter/material.dart';

class CheckButton extends StatelessWidget {
  final void Function() function;
  final double? width;
  final double? height;
  final Color? boxColor;
  final Color? iconColor;

  const CheckButton(this.function,
      {super.key, this.width, this.height, this.boxColor, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: boxColor,
        ),
        child: Center(
          child: Icon(
            Icons.check,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
