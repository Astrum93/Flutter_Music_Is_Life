import 'package:MusicIsLife/main/tab/home/home_fragment.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;

  const SearchAppBar({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeFragment()));
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  textInputAction: TextInputAction.search,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)),
                    hintText: '검색어를 입력 해주세요.',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, 56.0);
}
