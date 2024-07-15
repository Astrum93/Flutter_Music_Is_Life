import 'package:flutter/material.dart';
import 'package:music_is_life/common/widget/width_height_widget.dart';

import '../data/search_data.dart';

class SearchResultUserInfo extends StatelessWidget with SearchDataProvider {
  SearchResultUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: searchData.userInfo.length,
          itemBuilder: (context, index) => Column(
            children: [
              const Height(10),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        searchData.userInfo[index].get('userProfileImage'),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  const Width(15),
                  Text(
                    searchData.userInfo[index].get('userName').toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Height(10),
            ],
          ),
        ),
      ),
    );
  }
}
