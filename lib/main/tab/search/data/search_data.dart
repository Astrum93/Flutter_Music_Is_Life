import 'package:MusicIsLife/main/tab/search/data/search_data_provider.dart';
import 'package:get/get.dart';

class SearchData extends GetxController {
  List searchContentsData = [];
  List searchUserInfoData = [];
  RxList contents = [].obs;
  RxList userInfo = [].obs;

  @override
  void onInit() {
    SearchDataProvider.getUserInfoDocId(searchUserInfoData);
    super.onInit();
  }
}
