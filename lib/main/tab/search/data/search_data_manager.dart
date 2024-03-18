import 'package:cloud_firestore/cloud_firestore.dart';

class SearchDataManager {
  static Future<List<T>> getUserInfoDataList<T>() async {
    final userInfoSnapshot =
        await FirebaseFirestore.instance.collection('UserInfo').get();
    final docs = userInfoSnapshot.docs;
    if (docs.isNotEmpty) {
      /// docs의 object들을 리스트로 변환해야 함
    }
    return [];
  }
}
