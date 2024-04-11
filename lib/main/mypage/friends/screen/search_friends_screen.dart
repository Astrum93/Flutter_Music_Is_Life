import 'package:MusicIsLife/main/tab/search/data/search_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFriendsScreen extends StatefulWidget {
  const SearchFriendsScreen({super.key});

  @override
  State<SearchFriendsScreen> createState() => _SearchFriendsScreenState();
}

class _SearchFriendsScreenState extends State<SearchFriendsScreen>
    with SearchDataProvider {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    Get.put(SearchData());

    /// 유저 검색
    controller.addListener(() {
      /// 유저 정보를 검색하는 searchFriend 실행
      searchData.searchFriend(controller.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 70,
          child: TextFormField(
            controller: controller,
            textInputAction: TextInputAction.search,
            cursorColor: Colors.grey,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              hintText: '사용자 ID를 입력 해주세요.',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ),
        GetBuilder<SearchData>(
            dispose: (state) => searchData.searchFriends.clear(),
            builder: (searchData) {
              return Obx(
                () => searchData.searchFriends.isEmpty
                    ? Container(
                        width: 100,
                        height: 100,
                        color: Colors.blue,
                      )
                    : Container(
                        width: 100,
                        height: 100,
                        color: Colors.red,
                      ),
              );
            }),
      ],
    );
  }
}
