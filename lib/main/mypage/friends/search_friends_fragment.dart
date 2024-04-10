import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:flutter/material.dart';

class SearchFriendsFragment extends StatefulWidget {
  const SearchFriendsFragment({super.key});

  @override
  State<SearchFriendsFragment> createState() => _SearchFriendsFragmentState();
}

class _SearchFriendsFragmentState extends State<SearchFriendsFragment>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
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
            SearchFriendsTabBar(tabController: tabController),
          ],
        ),
      ),
    );
  }
}

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
