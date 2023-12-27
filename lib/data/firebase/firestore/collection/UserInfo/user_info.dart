import 'package:MusicIsLife/data/memory/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../common/constants.dart';

// Firebase Authentication Instance
final _auth = FirebaseAuth.instance;

class UserInfo {
  final String userMail;
  final String userName;
  final String userPhoneNumber;
  final String userProfileBgImage;
  final String userProfileInfo;

  UserInfo(
    this.userMail,
    this.userName,
    this.userPhoneNumber,
    this.userProfileBgImage,
    this.userProfileInfo,
  );
}

void saveUserData(UserData userData) async {
  final joinUser = await _auth.createUserWithEmailAndPassword(
    email: userData.mail,
    password: userData.password,
  );

  // Firestore의 UserInfo에 저장
  await FirebaseFirestore.instance
      .collection('UserInfo')
      .doc(joinUser.user!.uid)
      .set({
    'userName': userData.name,
    'userMail': userData.mail,
    'userPhoneNumber': userData.phone,
    'userProfileImage': baseProfileImage,
    'userProfileInfo': '',
    'userProfileBgImage': baseProfileBgImage,
  });
}
