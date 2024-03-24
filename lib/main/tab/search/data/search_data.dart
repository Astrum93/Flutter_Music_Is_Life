import 'package:MusicIsLife/main/tab/search/data/search_data_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

abstract mixin class SearchDataProvider {
  /// late 키워드를 사용하는 이유는 state생성이 initState보다 빠르기 때문
  late final searchData = Get.find<SearchData>();
}

class SearchData extends GetxController {
  List searchUserInfoData = [];
  List searchContentsData = [];
  RxList userInfo = [].obs;
  RxList contents = [].obs;

  @override
  void onInit() {
    SearchDataUtil.getUserInfoDoc();
    SearchDataUtil.getContentsDoc(searchContentsData);
    super.onInit();
  }

  void search(String keyword) async {
    if (keyword.isEmpty) {
      userInfo.clear();
      contents.clear();
      return;
    }

    final List<DocumentSnapshot> userInfoDocs =
        await SearchDataUtil.getUserInfoDoc();

    userInfo.value = userInfoDocs.where((doc) {
      final String id = doc.id;
      // Document의 id에 keyword가 포함되는지 확인
      return id.toLowerCase().contains(keyword.toLowerCase());
    }).toList();

    contents.value = searchContentsData
        .where((element) => element.contains(keyword))
        .toList();
  }
}
