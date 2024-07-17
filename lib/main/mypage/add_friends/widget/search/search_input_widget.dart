import 'package:flutter/material.dart';

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: TextFormField(
        controller: controller,
        textInputAction: TextInputAction.search,
        cursorColor: Colors.grey,
        keyboardType: TextInputType.text,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintText: '사용자 ID를 입력 해주세요.',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          contentPadding: EdgeInsets.all(10),
        ),
      ),
    );
  }
}
