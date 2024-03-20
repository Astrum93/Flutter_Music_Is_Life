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

  /// late 키워드를 사용하는 이유는 state생성이 initState보다 빠르기 때문
  late final userInfoSearchData = Get.find<SearchData>();

  @override
  void initState() {
    Get.put(SearchData());
    controller.addListener(() {
      // debugPrint(controller.text);
      /// 유저 정보를 검색하는 searchUserInfo 실행
      userInfoSearchData.searchUserInfo(controller.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    /// *** delete는 Generic Type으로 관리 ***
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
