import 'package:flutter/material.dart';

import 'data/search_data.dart';

class SearchResultUserInfo extends StatelessWidget with SearchDataProvider {
  SearchResultUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: ListView.builder(
          itemCount: searchData.userInfo.length,
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
