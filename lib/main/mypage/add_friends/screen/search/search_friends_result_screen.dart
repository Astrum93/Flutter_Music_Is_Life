import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/main/mypage/add_friends/friend_profile_widget.dart';
import 'package:MusicIsLife/main/mypage/add_friends/request_friends_dialog.dart';
import 'package:MusicIsLife/main/tab/search/data/search_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFriendsResultScreen extends StatelessWidget {
  const SearchFriendsResultScreen({
    super.key,
    required this.searchData,
  });

  final SearchData searchData;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchData>(
      dispose: (state) => searchData.searchFriends.clear(),
      builder: (searchData) {
        return Obx(
          () => searchData.searchFriends.isEmpty
              ? const Text(
                  '검색 결과가 없습니다.',
                  style: TextStyle(color: Colors.red),
                )
              : Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 150,
                    ),
                    itemCount: searchData.searchFriends.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => RequestFriendDialog(
                            rxList: searchData.searchFriends,
                            index: index,
                            data:
                                searchData.searchFriends[index].get('userName'),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          FriendProfileWidget(
                              rxList: searchData.searchFriends,
                              index: index,
                              boxColor: AppColors.veryDarkGrey,
                              borderColor: Colors.amberAccent),
                          height10,
                          Text(
                            searchData.searchFriends[index].get('userName'),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
