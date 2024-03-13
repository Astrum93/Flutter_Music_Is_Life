import 'package:flutter/material.dart';

class MiniButton extends StatefulWidget {
  final Widget Function(BuildContext) builder;
  final String text;
  final IconData icon;

  const MiniButton({
    super.key,
    required this.builder,
    required this.text,
    required this.icon,
  });

  @override
  State<MiniButton> createState() => _MiniButtonState();
}

class _MiniButtonState extends State<MiniButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: widget.builder));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              blurRadius: 7,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: Colors.grey,
              ),
              const SizedBox(width: 10),
              Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
