import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FireStoreDataUtil {
  final userInfoCollection = FirebaseFirestore.instance.collection('UserInfo');
  final userContentsCollection =
      FirebaseFirestore.instance.collection('UserContents');
  final currentUser = FirebaseAuth.instance.currentUser;

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

  static Future<DocumentSnapshot<Map<String, dynamic>>> loggedUserDoc() async {
    final userInfo = await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(FirebaseAuth.instance.currentUser!.displayName)
        .get();
    return userInfo;
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>>
      loggedUserFriendsDoc() async {
    final userFriends = await FirebaseFirestore.instance
        .collection('UserFriends')
        .doc(FirebaseAuth.instance.currentUser!.displayName)
        .get();
    return userFriends;
  }
}

/// DocumentSnapshot을 RxMap으로 바꿔주는 extension

extension ToRxMap on DocumentSnapshot<Map<String, dynamic>> {
  RxMap<String, dynamic> toRxMap() {
    return RxMap<String, dynamic>.from(data()!);
  }
}
