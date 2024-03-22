import 'package:MusicIsLife/main/tab/search/data/search_data_util.dart';
import 'package:get/get.dart';

abstract mixin class SearchDataProvider {
  /// late 키워드를 사용하는 이유는 state생성이 initState보다 빠르기 때문
  late final searchData = Get.find<SearchData>();
}

class SearchData extends GetxController {
  List searchUserInfoData = [];
  Map<dynamic, dynamic> searchContentsData = {};
  RxList contents = [].obs;
  RxMap userInfo = {}.obs;

  @override
  void onInit() {
    SearchDataUtil.getUserInfoDoc(searchUserInfoData);
    SearchDataUtil.getContentsDoc(searchContentsData);
    super.onInit();
  }

  void search(String keyword) {
    if (keyword.isEmpty) {
      userInfo.clear();
      contents.clear();
      return;
    }
    userInfo.value = {
      searchUserInfoData
          .map((element) => element.id)
          .where((element) => element.contains(keyword)): ''
    };
    contents.value = searchContentsData.keys
        .where((element) => element.contains(keyword))
        .toList();
  }
}
