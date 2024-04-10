import 'package:MusicIsLife/main/mypage/friends/screen/recommend_friends_screen.dart';
import 'package:MusicIsLife/main/mypage/friends/screen/search_friends_screen.dart';
import 'package:MusicIsLife/main/tab/search/data/search_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFriendsTabBarView extends StatelessWidget {
  const SearchFriendsTabBarView({
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
          searchData.userInfo.isEmpty
              ? Center(
                  child: Image.asset(
                    'assets/icon/just_be_happy.png',
                    color: Colors.white,
                    scale: 3,
                  ),
                )
              : const RecommendsFriendsScreen(),
          searchData.contents.isEmpty
              ? Center(
                  child: Image.asset(
                    'assets/icon/just_be_happy.png',
                    color: Colors.white,
                    scale: 3,
                  ),
                )
              : const SearchFriendsScreen(),
        ],
      ),
    );
  }
}
