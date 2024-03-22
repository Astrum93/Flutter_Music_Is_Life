import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchDataUtil {
  static Future<List> getUserInfoDoc(List idList) async {
    final userInfoSnapshot =
        await FirebaseFirestore.instance.collection('UserInfo').get();
    final docs = userInfoSnapshot.docs;
    if (docs.isNotEmpty) {
      /// docs의 doc들의 id값을 리스트로 변환해야 함
      for (var doc in docs) {
        idList.add(doc);
      }
      debugPrint(idList.toString());
    }
    return [];
  }

  static Future<Map<dynamic, dynamic>> getContentsDoc(
      Map<dynamic, dynamic> idList) async {
    final userContentsSnapshot =
        await FirebaseFirestore.instance.collection('UserContents').get();
    final docs = userContentsSnapshot.docs;
    if (docs.isNotEmpty) {
      /// docs의 doc들의 id값을 리스트로 변환해야 함
      for (var doc in docs) {
        idList.update(doc.data()['title'], doc.data()['contentsImage']);
      }
    }
    return {};
  }
}
