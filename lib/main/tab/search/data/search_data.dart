import 'package:MusicIsLife/main/tab/search/data/search_data_util.dart';
import 'package:get/get.dart';

abstract mixin class SearchDataProvider {
  /// late 키워드를 사용하는 이유는 state생성이 initState보다 빠르기 때문
  late final searchData = Get.find<SearchData>();
}

class SearchData extends GetxController {
  List searchContentsData = [];
  List searchUserInfoData = [];
  RxList contents = [].obs;
  RxList userInfo = [].obs;

  @override
  void onInit() {
    SearchDataUtil.getUserInfoDocId(searchUserInfoData);
    SearchDataUtil.getContentsDocId(searchContentsData);
    super.onInit();
  }

  void search(String keyword) {
    if (keyword.isEmpty) {
      userInfo.clear();
      contents.clear();
      return;
    }
    userInfo.value = searchUserInfoData
        .where((element) => element.contains(keyword))
        .toList();
    //debugPrint(userInfo.toString());
    contents.value = searchContentsData
        .where((element) => element.contains(keyword))
        .toList();
  }
}
