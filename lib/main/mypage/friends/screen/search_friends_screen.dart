import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
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
                  ? const Text(
                      '검색 결과가 없습니다.',
                      style: TextStyle(color: Colors.red),
                    )
                  : Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 150,
                        ),
                        itemCount: searchData.searchFriends.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                  color: AppColors.veryDarkGrey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 40,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      searchData.searchFriends[index]
                                          .get('userProfileImage'),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            height10,
                            Text(
                              searchData.searchFriends[index].get('userName'),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
            );
          },
        ),
      ],
    );
  }
}
