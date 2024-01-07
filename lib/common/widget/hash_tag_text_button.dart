import 'package:flutter/material.dart';

class HashTagTextButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;

  const HashTagTextButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.tag_rounded,
        color: Colors.amber,
        size: 18,
      ),
      label: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        maxLines: 1,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
