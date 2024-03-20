import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/main/tab/search/data/search_data.dart';
import 'package:MusicIsLife/main/tab/search/search_app_bar.dart';
import 'package:MusicIsLife/main/tab/search/search_result_contents_screen.dart';
import 'package:MusicIsLife/main/tab/search/search_result_user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    Get.put(SearchData());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<SearchData>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchAppBar(controller: controller),
        body: ListView(
          children: const [
            height30,
            SearchResultUserInfo(),
            height30,
            SearchResultContents(),
          ],
        ),
      ),
    );
  }
}
