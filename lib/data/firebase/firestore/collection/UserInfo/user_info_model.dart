import 'package:MusicIsLife/data/memory/user_join_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../common/constants.dart';

// Firebase Authentication Instance
final _auth = FirebaseAuth.instance;

// FireStore collection 참조 변수
CollectionReference userInfoCollection =
    FirebaseFirestore.instance.collection('UserInfo');

class UserInfoModel {
  final String userName;
  final String userMail;
  final String userPhoneNumber;
  final String userProfileBgImage;
  final String userProfileInfo;

  UserInfoModel(
    this.userName,
    this.userMail,
    this.userPhoneNumber,
    this.userProfileBgImage,
    this.userProfileInfo,
  );

  /// UserInfo 데이터 init
  static Future<void> userInfoInit() async {
    // FireStore collection 참조 변수
    CollectionReference userInfoCollection =
        FirebaseFirestore.instance.collection('UserInfo');
  }

  /// Document 불러오기
  static Future getDocument() async {
    final docs = await userInfoCollection.doc().get();
  }
}

/// 회원가입시 UserInfo Collection에 데이터를 저장하는 함수
void saveUserData(UserJoinData userJoinData) async {
  await _auth.createUserWithEmailAndPassword(
    email: userJoinData.mail,
    password: userJoinData.password,
  );

  await _auth.currentUser!.updateDisplayName(userJoinData.name);

  // Firestore의 UserInfo에 저장
  await userInfoCollection.doc(userJoinData.name).set({
    'userName': userJoinData.name,
    'userMail': userJoinData.mail,
    'userPhoneNumber': userJoinData.phone,
    'userProfileImage': baseProfileImage,
    'userProfileInfo': '',
    'userProfileBgImage': baseProfileBgImage,
  });
}