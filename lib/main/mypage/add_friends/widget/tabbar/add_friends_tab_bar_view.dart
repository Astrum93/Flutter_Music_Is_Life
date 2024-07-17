import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_is_life/main/mypage/add_friends/widget/tabbar/recommend_friends_tab_bar_view.dart';
import 'package:music_is_life/main/mypage/add_friends/widget/tabbar/search_friends_tab_bar_view.dart';
import 'package:music_is_life/main/tab/search/data/search_data.dart';

class AddFriendsTabBarView extends StatelessWidget {
  const AddFriendsTabBarView({
    Key? key,
    required this.tabController,
    required this.searchData,
  }) : super(key: key);

  final TabController tabController;
  final SearchData searchData;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TabBarView(
        controller: tabController,
        children: [
          searchData.recommendFriends.isEmpty
              ? Center(
                  child: Image.asset(
                    'assets/icon/just_be_happy.png',
                    color: Colors.white,
                    scale: 3,
                  ),
                )
              : RecommendsFriendsTabBarView(),
          const SearchFriendsTabBarView(),
        ],
      ),
    );
  }
}
