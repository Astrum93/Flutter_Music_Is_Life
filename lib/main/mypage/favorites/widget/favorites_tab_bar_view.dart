import 'package:flutter/material.dart';
import 'package:music_is_life/main/mypage/favorites/widget/follower_tab_bar_view.dart';
import 'package:music_is_life/main/mypage/favorites/widget/following_tab_bar_view.dart';

class FavoritesTabBarView extends StatelessWidget {
  const FavoritesTabBarView({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: const [
          FollowingTabBarView(),
          FollowerTabBarView(),
        ],
      ),
    );
  }
}
