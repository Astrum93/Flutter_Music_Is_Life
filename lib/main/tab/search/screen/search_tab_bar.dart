import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_is_life/main/tab/search/data/search_data.dart';
import 'package:music_is_life/main/tab/search/screen/search_result_contents_screen.dart';
import 'package:music_is_life/main/tab/search/screen/search_result_user_info_screen.dart';

class SearchTabBarView extends StatelessWidget {
  const SearchTabBarView({
    super.key,
    required this.tabController,
    required this.searchData,
  });

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
              : SearchResultUserInfo(),
          searchData.contents.isEmpty
              ? Center(
                  child: Image.asset(
                    'assets/icon/just_be_happy.png',
                    color: Colors.white,
                    scale: 3,
                  ),
                )
              : SearchResultContents(),
        ],
      ),
    );
  }
}

class SearchTabBar extends StatelessWidget {
  const SearchTabBar({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      labelColor: Colors.white,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      overlayColor: WidgetStatePropertyAll(
        Colors.lightBlue.withOpacity(0.2),
      ),
      indicatorWeight: 0.1,
      indicatorColor: Colors.amber,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: Colors.transparent,
      tabs: const [
        Tab(
          icon: Icon(
            Icons.person_outline_rounded,
          ),
          text: '사용자 검색 결과',
        ),
        Tab(
          icon: Icon(
            Icons.library_music_outlined,
          ),
          text: '게시물 검색 결과',
        ),
      ],
    );
  }
}
