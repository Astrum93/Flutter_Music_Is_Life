import 'package:flutter/material.dart';

class GoogleJoinButton extends StatelessWidget {
  const GoogleJoinButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          minimumSize: const Size(120, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.orange.shade900),
      icon: const Icon(Icons.add),
      label: const Text('Google'),
    );
  }
}
