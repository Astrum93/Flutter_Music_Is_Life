import 'package:flutter/material.dart';
import 'package:music_is_life/main/tab/home/home_fragment.dart';

import 'data/search_data.dart';

class SearchAppBar extends StatelessWidget
    with SearchDataProvider
    implements PreferredSizeWidget {
  final TextEditingController controller;

  SearchAppBar({required this.controller, super.key});

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
                  searchData.contents.clear();
                  searchData.userInfo.clear();
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
