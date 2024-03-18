import 'package:cloud_firestore/cloud_firestore.dart';

class SearchDataManager {
  static Future<List<T>> getUserInfoDataList<T>() async {
    final userInfoRef = FirebaseFirestore.instance.collection('UserInfo');
    await userInfoRef.get();
    return [];
  }
}
