import 'package:MusicIsLife/main/mypage/add_friends/screen/search/search_friends_result_screen.dart';
import 'package:MusicIsLife/main/mypage/add_friends/screen/search/search_input_widget.dart';
import 'package:MusicIsLife/main/tab/search/data/search_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFriendsTabBarView extends StatefulWidget {
  const SearchFriendsTabBarView({super.key});

  @override
  State<SearchFriendsTabBarView> createState() =>
      _SearchFriendsTabBarViewState();
}

class _SearchFriendsTabBarViewState extends State<SearchFriendsTabBarView>
    with SearchDataProvider {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    Get.put(SearchData());

    /// 유저 검색
    controller.addListener(() {
      /// 유저 정보를 검색하는 searchFriend 실행
      searchData.searchFriend(controller.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SearchInputWidget(controller: controller),
          SearchFriendsResultScreen(searchData: searchData),
        ],
      ),
    );
  }
}
