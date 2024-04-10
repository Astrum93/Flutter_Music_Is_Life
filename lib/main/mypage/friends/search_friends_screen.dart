import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:flutter/material.dart';

class SearchFriendsScreen extends StatefulWidget {
  const SearchFriendsScreen({super.key});

  @override
  State<SearchFriendsScreen> createState() => _SearchFriendsScreenState();
}

class _SearchFriendsScreenState extends State<SearchFriendsScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Material(
        child: Column(
          children: [
            height30,
            Center(
              child: Text(
                '새로운 \n친　구',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50),
              ),
            ),
            Height(60),
          ],
        ),
      ),
    );
  }
}
