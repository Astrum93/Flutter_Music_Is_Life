import 'package:MusicIsLife/common/widget/line.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/width_height_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: TextFormField(
                cursorColor: Colors.grey,
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
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
            const Line(color: Colors.amber),
            height5,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.green,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.amber,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.green,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.amber,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.red,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.green,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.amber,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
