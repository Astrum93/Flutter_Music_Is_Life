import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/main/tab/search/search_app_bar.dart';
import 'package:MusicIsLife/main/tab/search/search_result_contents_screen.dart';
import 'package:MusicIsLife/main/tab/search/search_result_user_screen.dart';
import 'package:flutter/material.dart';

class SearchFragment extends StatefulWidget {
  const SearchFragment({super.key});

  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchAppBar(controller: controller),
        body: ListView(
          children: const [
            height30,
            SearchResultUser(),
            height30,
            SearchResultContents(),
          ],
        ),
      ),
    );
  }
}
