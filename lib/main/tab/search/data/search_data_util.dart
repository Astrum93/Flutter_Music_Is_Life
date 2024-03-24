import 'package:cloud_firestore/cloud_firestore.dart';

class SearchDataUtil {
  static Future<List<DocumentSnapshot>> getUserInfoDoc() async {
    final userInfoSnapshot =
        await FirebaseFirestore.instance.collection('UserInfo').get();
    final docs = userInfoSnapshot.docs;
    return docs;
  }

  static Future<List<DocumentSnapshot>> getContentsDoc() async {
    final userContentsSnapshot =
        await FirebaseFirestore.instance.collection('UserContents').get();
    final docs = userContentsSnapshot.docs;
    return docs;
  }
}
