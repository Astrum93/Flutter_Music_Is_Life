import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_is_life/common/widget/width_height_widget.dart';
import 'package:music_is_life/main/mypage/add_friends/screen/tabbar/add_friends_tab_bar.dart';
import 'package:music_is_life/main/mypage/add_friends/screen/tabbar/add_friends_tab_bar_view.dart';
import 'package:music_is_life/main/tab/search/data/search_data.dart';

class AddFriendsFragment extends StatefulWidget {
  const AddFriendsFragment({super.key});

  @override
  State<AddFriendsFragment> createState() => _AddFriendsFragmentState();
}

class _AddFriendsFragmentState extends State<AddFriendsFragment>
    with SearchDataProvider, SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    Get.put(SearchData());

    /// 추천 친구
    searchData.userInfoCreate();

    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    /// *** delete는 Generic Type으로 관리 ***
    Get.delete<SearchData>();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          children: [
            height30,
            const Center(
              child: Text(
                '새로운 \n친　구',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50),
              ),
            ),
            const Height(60),
            AddFriendsTabBar(tabController: tabController),
            Expanded(
              child: GetBuilder<SearchData>(
                builder: (searchData) {
                  return AddFriendsTabBarView(
                      tabController: tabController, searchData: searchData);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
