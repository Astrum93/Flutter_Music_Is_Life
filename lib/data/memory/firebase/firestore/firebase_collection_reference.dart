import 'package:cloud_firestore/cloud_firestore.dart';

abstract mixin class FirebaseCollectionReference {
  /// FireStore collection 참조 변수

  final CollectionReference userInfoCollection =
      FirebaseFirestore.instance.collection('UserInfo');

  final CollectionReference userContentsCollection =
      FirebaseFirestore.instance.collection('UserContents');

  final CollectionReference userFriendsCollection =
      FirebaseFirestore.instance.collection('UserFriends');
}
