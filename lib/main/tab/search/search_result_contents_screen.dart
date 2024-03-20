import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/search_data.dart';

class SearchResultContents extends StatelessWidget {
  SearchResultContents({super.key});

  /// late 키워드를 사용하는 이유는 state생성이 initState보다 빠르기 때문
  late final searchData = Get.find<SearchData>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: ListView.builder(
          itemBuilder: (context, index) => Text(
            searchData.userInfo[index],
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
