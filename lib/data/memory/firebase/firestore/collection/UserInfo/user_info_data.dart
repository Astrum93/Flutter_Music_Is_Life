import 'package:MusicIsLife/data/memory/user_join_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../../common/constants.dart';

// Firebase Authentication Instance
final _auth = FirebaseAuth.instance;

// FireStore collection 참조 변수
CollectionReference userInfoCollection =
    FirebaseFirestore.instance.collection('UserInfo');

// 현재 인증된 유저 이름
final _displayName = _auth.currentUser!.displayName;

class UserInfoData {
  final String? userName,
      userMail,
      userPhoneNumber,
      userProfileBgImage,
      userProfileInfo,
      userProfileImage;

  UserInfoData({
    this.userName,
    this.userMail,
    this.userPhoneNumber,
    this.userProfileBgImage,
    this.userProfileInfo,
    this.userProfileImage,
  });

  /// 가져온 정보를 UserInfoModel의 생성자로 정의
  factory UserInfoData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserInfoData(
      userName: data?['userName'],
      userMail: data?['userMail'],
      userPhoneNumber: data?['userPhoneNumber'],
      userProfileImage: data?['userProfileImage'],
      userProfileBgImage: data?['userProfileBgImage'],
      userProfileInfo: data?['userProfileInfo'],
    );
  }

  /// Json 형태의 Map 데이터로 변환
  Map<String, dynamic> toFirestore() {
    return {
      if (userName != null) "userName": userName,
      if (userMail != null) "userMail": userMail,
      if (userPhoneNumber != null) "userPhoneNumber": userPhoneNumber,
      if (userProfileImage != null) "userProfileImage": userProfileImage,
      if (userProfileBgImage != null) "userProfileBgImage": userProfileBgImage,
      if (userProfileInfo != null) "userProfileInfo": userProfileInfo,
    };
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
