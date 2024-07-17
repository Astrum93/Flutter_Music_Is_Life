import 'package:flutter/material.dart';

class FavoritesFragment extends StatelessWidget {
  const FavoritesFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('즐겨찾기'),
          centerTitle: true,
        ),
        body: FavoritesTabbarView(),
      ),
    );
  }
}
