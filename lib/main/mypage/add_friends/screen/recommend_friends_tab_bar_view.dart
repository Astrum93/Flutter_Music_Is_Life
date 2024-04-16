import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/main/mypage/add_friends/friend_profile_widget.dart';
import 'package:MusicIsLife/main/mypage/add_friends/request_friends_dialog.dart';
import 'package:MusicIsLife/main/tab/search/data/search_data.dart';
import 'package:flutter/material.dart';

class RecommendsFriendsTabBarView extends StatelessWidget
    with SearchDataProvider {
  RecommendsFriendsTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 150,
        ),
        itemCount: searchData.recommendFriends.length,
        itemBuilder: (context, index) => GestureDetector(
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) => RequestFriendDialog(
                searchData: searchData,
                index: index,
                data: searchData.recommendFriends[index].get('userName'),
              ),
            );
          },
          child: Column(
            children: [
              FriendProfileWidget(
                searchData: searchData.recommendFriends[index],
                index: index,
                borderColor: Colors.transparent,
                boxColor: (index == 0)
                    ? Colors.redAccent
                    : (index == 1)
                        ? Colors.blue
                        : (index == 2)
                            ? Colors.greenAccent
                            : AppColors.veryDarkGrey,
              ),
              height10,
              Text(
                searchData.recommendFriends[index].get('userName'),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
