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

class UserInfo {
  final String userName;
  final String userMail;
  final String userPhoneNumber;
  final String userProfileBgImage;
  final String userProfileInfo;
  final String userProfileImage;

  UserInfo({
    required this.userName,
    required this.userMail,
    required this.userPhoneNumber,
    required this.userProfileBgImage,
    required this.userProfileInfo,
    required this.userProfileImage,
  });

  /// 가져온 정보를 UserInfoModel의 생성자로 정의
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userName: json['userName'],
      userMail: json['userMail'],
      userPhoneNumber: json['userPhoneNumber'],
      userProfileImage: json['userProfileImage'],
      userProfileBgImage: json['userProfileBgImage'],
      userProfileInfo: json['userProfileInfo'],
    );
  }

  /// Json 형태의 Map 데이터로 변환
  Map<String, dynamic> userInfoToJson() {
    return {
      "userName": userName,
      "userMail": userMail,
      "userPhoneNumber": userPhoneNumber,
      "userProfileImage": userProfileImage,
      "userProfileBgImage": userProfileBgImage,
      "userProfileInfo": userProfileInfo,
    };
  }

  /// Document 불러오기
  static Future getDocument() async {
    final docs = await userInfoCollection.doc(_displayName).get();
    return docs.data();
  }

  /// json 직렬화
  final userInfoRef = userInfoCollection.withConverter(
      fromFirestore: (snapshot, _) => UserInfo.fromJson(snapshot.data()!),
      toFirestore: (value, _) => value.userInfoToJson());
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
