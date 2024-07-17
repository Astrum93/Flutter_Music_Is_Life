import 'package:flutter/material.dart';
import 'package:music_is_life/main/mypage/favorites/widget/favorites_tabbar.dart';

class FavoritesFragment extends StatefulWidget {
  const FavoritesFragment({super.key});

  @override
  State<FavoritesFragment> createState() => _FavoritesFragmentState();
}

class _FavoritesFragmentState extends State<FavoritesFragment>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('즐겨찾기'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            FavoritesTabBar(tabController: tabController),
            //FavoritesTabbarView(),
          ],
        ),
      ),
    );
  }
}
