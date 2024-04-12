import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/main/tab/search/data/search_data.dart';
import 'package:flutter/material.dart';

class RecommendsFriendsTabBarView extends StatelessWidget
    with SearchDataProvider {
  RecommendsFriendsTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 150,
      ),
      itemCount: searchData.recommendFriends.length,
      itemBuilder: (context, index) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: (index == 0)
                    ? Colors.redAccent
                    : (index == 1)
                        ? Colors.blue
                        : (index == 2)
                            ? Colors.greenAccent
                            : AppColors.veryDarkGrey,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    searchData.recommendFriends[index].get('userProfileImage'),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
          ),
          height10,
          Text(
            searchData.recommendFriends[index].get('userName'),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
