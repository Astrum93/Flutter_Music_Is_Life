import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  static Future<DocumentSnapshot<Object?>> loggedUserDoc() async {
    final userinfo = await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(FirebaseAuth.instance.currentUser!.displayName)
        .get();
    return userinfo;
  }
}
