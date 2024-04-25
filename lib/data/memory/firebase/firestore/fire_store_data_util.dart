import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FireStoreDataUtil {
  /// 모든 UserInfoCollection Docs
  static Future<List<DocumentSnapshot>> getUserInfoDoc() async {
    final userInfoSnapshot =
        await FirebaseFirestore.instance.collection('UserInfo').get();
    final docs = userInfoSnapshot.docs;
    return docs;
  }

  /// 모든 UserContents Docs
  static Future<List<DocumentSnapshot>> getContentsDoc() async {
    final userContentsSnapshot =
        await FirebaseFirestore.instance.collection('UserContents').get();
    final docs = userContentsSnapshot.docs;
    return docs;
  }

  /// 현재 로그인한 UserInfo 컬렉션의 Doc
  static Future<DocumentSnapshot<Map<String, dynamic>>> currentUserDoc() async {
    final userInfo = await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(FirebaseAuth.instance.currentUser!.displayName)
        .get();
    return userInfo;
  }

  /// 현재 로그인한 User의 UserFriends Docs
  static Future<DocumentSnapshot<Map<String, dynamic>>>
      currentUserFriendsDoc() async {
    final userFriends = await FirebaseFirestore.instance
        .collection('UserFriends')
        .doc(FirebaseAuth.instance.currentUser!.displayName)
        .get();
    return userFriends;
  }

  /// 현재 로그인한 User가 포함된 Chats
  static Future<List<DocumentSnapshot>> getUserChats() async {
    final userChatSnapshot = await FirebaseFirestore.instance
        .collection('UserChats')
        .where('member',
            arrayContains: FirebaseAuth.instance.currentUser!.displayName)
        .get();
    final docs = userChatSnapshot.docs;
    return docs;
  }
}

/// DocumentSnapshot을 RxMap으로 바꿔주는 extension

extension ToRxMap on DocumentSnapshot<Map<String, dynamic>> {
  RxMap<String, dynamic> toRxMap() {
    return RxMap<String, dynamic>.from(data()!);
  }
}
