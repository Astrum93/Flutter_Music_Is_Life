import 'package:MusicIsLife/main/tab/search/data/search_data.dart';
import 'package:MusicIsLife/main/tab/search/screen/search_result_contents_screen.dart';
import 'package:MusicIsLife/main/tab/search/screen/search_result_user_info_screen.dart';
import 'package:flutter/material.dart';

class SearchTabBarView extends StatelessWidget {
  const SearchTabBarView({
    Key? key,
    required this.tabController,
    required this.searchData,
  }) : super(key: key);

  final TabController tabController;
  final SearchData searchData;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        searchData.userInfo.isEmpty
            ? Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                height: 50,
              )
            : SearchResultUserInfo(),
        searchData.contents.isEmpty
            ? Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                height: 50,
              )
            : SearchResultContents(),
      ],
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
      overlayColor: MaterialStatePropertyAll(
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
