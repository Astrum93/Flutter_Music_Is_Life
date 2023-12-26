import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../screen/home/home.dart';

abstract mixin class FirebaseAuthUser {
  // Firebase Authentication Instance
  final _auth = FirebaseAuth.instance;

  // Firebase 인증된 현재 유저
  final User? user = FirebaseAuth.instance.currentUser;

  // Firebase 인증된 uid
  final currentUid = FirebaseAuth.instance.currentUser!.uid;
}
