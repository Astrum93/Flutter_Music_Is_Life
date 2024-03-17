import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:flutter/material.dart';

class SearchResultContents extends StatefulWidget {
  const SearchResultContents({super.key});

  @override
  State<SearchResultContents> createState() => _SearchResultContentsState();
}

class _SearchResultContentsState extends State<SearchResultContents> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height5,
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
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
    );
  }
}
