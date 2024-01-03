import 'package:flutter/material.dart';

class HashTagBox extends StatefulWidget {
  final TextEditingController? controller;
  final String text;

  const HashTagBox({
    super.key,
    this.controller,
    required this.text,
  });

  @override
  State<HashTagBox> createState() => _HashTagBoxState();
}

class _HashTagBoxState extends State<HashTagBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),

      // 입력 창
      child: TextField(
        style: const TextStyle(color: Colors.grey),
        cursorColor: Colors.blue,
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.tag,
            color: Colors.amber,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
          ),
          hintText: widget.text,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
