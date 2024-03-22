import 'package:cloud_firestore/cloud_firestore.dart';

class SearchDataUtil {
  static Future<List> getUserInfoDoc(List idList) async {
    final userInfoSnapshot =
        await FirebaseFirestore.instance.collection('UserInfo').get();
    final docs = userInfoSnapshot.docs;
    if (docs.isNotEmpty) {
      /// docs의 doc들의 id값을 리스트로 변환해야 함
      for (var doc in docs) {
        idList.add(doc.get('userName'));
      }
    }
    return [];
  }

  static Future<List> getContentsDoc(List idList) async {
    final userContentsSnapshot =
        await FirebaseFirestore.instance.collection('UserContents').get();
    final docs = userContentsSnapshot.docs;
    if (docs.isNotEmpty) {
      /// docs의 doc들의 id값을 리스트로 변환해야 함
      for (var doc in docs) {
        //debugPrint(doc.id.toString());
        var docId = doc.id.toString();
        idList.add(docId);
      }
      //debugPrint(idList.toString());
    }
    return [];
  }
}
