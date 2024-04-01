import 'package:MusicIsLife/main/tab/search/data/search_data.dart';
import 'package:MusicIsLife/main/tab/search/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'search_tab_bar.dart';

class SearchFragment extends StatefulWidget {
  const SearchFragment({super.key});

  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment>
    with SearchDataProvider, SingleTickerProviderStateMixin {
  final TextEditingController controller = TextEditingController();
  late final TabController tabController;

  @override
  void initState() {
    Get.put(SearchData());
    controller.addListener(() {
      /// 유저 정보를 검색하는 searchUserInfo 실행
      searchData.search(controller.text);
    });
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
      child: Scaffold(
        appBar: SearchAppBar(controller: controller),
        body: Column(
          children: [
            SearchTabBar(tabController: tabController),
            Expanded(
              child: Obx(
                () => SearchTabBarView(
                    tabController: tabController, searchData: searchData),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
