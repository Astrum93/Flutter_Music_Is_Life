import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchData extends GetxController {
  List searchContentsData = [];
  List searchUserInfoData = [];
  RxList contents = [].obs;
  RxList userInfo = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  static Future<List<T>> getUserInfoDataList<T>() async {
    final userInfoSnapshot =
        await FirebaseFirestore.instance.collection('UserInfo').get();
    final docs = userInfoSnapshot.docs;
    if (docs.isNotEmpty) {
      /// docs의 object들을 리스트로 변환해야 함
      for (var a in docs) {
        print(a.data());
        print('end');
      }
    }
    return [];
  }
}
