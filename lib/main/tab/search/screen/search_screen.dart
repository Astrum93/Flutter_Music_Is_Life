import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/main/tab/search/data/search_data.dart';
import 'package:MusicIsLife/main/tab/search/screen/search_result_contents_screen.dart';
import 'package:MusicIsLife/main/tab/search/screen/search_result_user_info_screen.dart';
import 'package:MusicIsLife/main/tab/search/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SearchDataProvider {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    Get.put(SearchData());
    controller.addListener(() {
      /// 유저 정보를 검색하는 searchUserInfo 실행
      searchData.search(controller.text);
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
        body: Obx(
          () => ListView(
            children: [
              height30,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '사용자 검색 결과',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              height5,
              searchData.userInfo.isEmpty
                  ? Container(
                      color: Colors.black,
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                    )
                  : SearchResultUserInfo(),
              height30,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '게시물 검색 결과',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              height5,
              searchData.contents.isEmpty
                  ? Container(
                      color: Colors.black,
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                    )
                  : SearchResultContents(),
            ],
          ),
        ),
      ),
    );
  }
}
