import 'package:flutter/material.dart';

class CheckButton extends StatelessWidget {
  final void Function() function;

  const CheckButton(this.function, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: const Center(
          child: Icon(
            Icons.check,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
