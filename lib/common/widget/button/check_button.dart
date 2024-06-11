import 'package:flutter/material.dart';

class CheckButton extends StatelessWidget {
  final void Function()? onTap;
  final double? width;
  final double? height;
  final Color? boxColor;
  final Color borderColor;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;

  const CheckButton({
    super.key,
    this.onTap,
    this.width,
    this.height,
    this.boxColor,
    required this.borderColor,
    this.icon,
    this.iconColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor),
          color: boxColor,
        ),
        child: Center(
          child: Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
