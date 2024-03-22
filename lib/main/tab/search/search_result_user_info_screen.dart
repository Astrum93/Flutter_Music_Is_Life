import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'data/search_data.dart';

class SearchResultUserInfo extends StatelessWidget with SearchDataProvider {
  SearchResultUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfoCollection =
        FirebaseFirestore.instance.collection('UserInfo');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: ListView.builder(
          itemCount: searchData.userInfo.length,
          itemBuilder: (context, index) => Row(
            children: [
              Image.network(''),
              width10,
              Text(
                searchData.userInfo[index],
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
