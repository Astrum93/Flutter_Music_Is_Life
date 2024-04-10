import 'package:flutter/material.dart';

class SearchFriendsTabBar extends StatelessWidget {
  const SearchFriendsTabBar({
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
      indicatorColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: Colors.transparent,
      tabs: const [
        Tab(
          icon: Icon(
            Icons.local_fire_department_outlined,
            color: Colors.red,
          ),
          text: '추천 친구',
        ),
        Tab(
          icon: Icon(
            Icons.search_rounded,
            color: Colors.orangeAccent,
          ),
          text: '유저 검색',
        ),
      ],
    );
  }
}
