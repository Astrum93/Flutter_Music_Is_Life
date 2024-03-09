import 'package:MusicIsLife/common/fcm/fcm_manager.dart';
import 'package:MusicIsLife/common/widget/hot_contents.dart';
import 'package:MusicIsLife/common/widget/search_music.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../common/firebase_auth/firebase_auth_user.dart';
import '../../mypage/mypage_screen.dart';
import '../../welcome_screen.dart';
import 'drawer/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with FirebaseAuthUser {
  int _currentIndex = 0;

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
            backgroundColor: Colors.black,

            /// AppBar
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Music is Life'),
              actions: [
                IconButton(
                  onPressed: () async {
                    // final fcmToken =
                    //     await FirebaseMessaging.instance.getToken();
                    // debugPrint(fcmToken);
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

            /// Drawer
            drawer: const HomeDrawer(),

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    /// 인기 게시물
                    const HotContents(),

                    const SizedBox(height: 40),

                    /// 메인 컬럼 세 번째 열
                    const Center(
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
                    const SizedBox(height: 20),

                    const SearchMusic(),

                    /// 메인 컬럼 SizedBox
                    const SizedBox(height: 40),

                    /// 메인 컬럼 네 번째 열
                    const Column(
                      children: [
                        Text(
                          '2222',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    /// 메인 컬럼 SizedBox
                    const SizedBox(height: 20),

                    /// 메인 컬럼 다섯 번째 컨테이너 (Invisible)
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 7,
                          )
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'test',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Bottom Navigation Bar
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey.shade600,
              showUnselectedLabels: true,
              backgroundColor: Colors.black,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: '홈',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_rounded),
                  label: '검색',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.create),
                  label: '글쓰기',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.messenger_outline_rounded),
                  label: '메신저',
                ),
              ],
            ),
          );
        }
        return const WelcomeScreen();
      },
    );
  }
}
