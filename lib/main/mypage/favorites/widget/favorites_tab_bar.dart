import 'package:flutter/material.dart';

class FavoritesTabBar extends StatelessWidget {
  const FavoritesTabBar({super.key, required this.tabController});

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
      indicatorColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: Colors.transparent,
      tabs: const [
        Tab(
          icon: Icon(
            Icons.group_add_outlined,
            color: Colors.red,
          ),
          text: '팔로잉',
        ),
        Tab(
          icon: Icon(
            Icons.groups,
            color: Colors.orangeAccent,
          ),
          text: '팔로워',
        ),
      ],
    );
  }
}
