import 'package:MusicIsLife/common/fcm/fcm_manager.dart';
import 'package:MusicIsLife/common/widget/hot_contents.dart';
import 'package:MusicIsLife/common/widget/search_music.dart';
import 'package:MusicIsLife/main/tab/home/drawer/home_drawer.dart';
import 'package:MusicIsLife/main/tab/search/search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../common/firebase_auth/firebase_auth_user.dart';
import '../../../mypage/mypage_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with FirebaseAuthUser {
  // FireStore collection 참조 변수
  CollectionReference userInfoCollection =
      FirebaseFirestore.instance.collection('UserInfo');

  CollectionReference userContentsCollection =
      FirebaseFirestore.instance.collection('UserContents');

  // 로그인된 유저
  User? loggedUser;

  // initstate 함수
  @override
  void initState() {
    super.initState();
    FcmManager.requestPermission();
    FcmManager.initialize();
    _getUserInfo();
  }

  // 현재 유저 정보를 불러오는 함수
  _getUserInfo() async* {
    var userinfo = await userInfoCollection.doc(user!.displayName).get();
    yield userinfo.data();
  }

  @override
  Widget build(BuildContext context) {
    // 배경 이미지
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Music is Life'),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
                  },
                  icon: const Icon(Icons.search_rounded),
                ),

                /// 개인 프로필
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => const MyScreen()),
                      ),
                    );
                  },
                  child: StreamBuilder(
                    stream: _getUserInfo(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 17,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  (snapshot.data as Map)['userProfileImage'],
                                ),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            );
                    },
                  ),
                ),
              ],
            ),
            drawer: const HomeDrawer(),
            body: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(height: 10),

                    /// 인기 게시물
                    HotContents(),

                    SizedBox(height: 40),

                    /// 메인 컬럼 세 번째 열
                    Center(
                      child: Text(
                        '음악 검색',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    /// 메인 컬럼 SizedBox
                    SizedBox(height: 20),

                    SearchMusic(),

                    /// 메인 컬럼 SizedBox
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
