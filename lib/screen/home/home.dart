import 'package:MusicIsLife/common/constants.dart';
import 'package:MusicIsLife/screen/home/drawer/home_drawer.dart';
import 'package:MusicIsLife/screen/mypage/mypage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/widget/invisible_box_basic.dart';
import '../../common/widget/invisible_box_hot.dart';
import '../../data/firebase/firebase_auth/firebase_authentication.dart';
import '../welcome.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with FirebaseAuthUser {
  // Firebase Firestore Instance
  final _firestore = FirebaseFirestore.instance;

  // FireStore collection 참조 변수
  CollectionReference userInfo =
      FirebaseFirestore.instance.collection('UserInfo');

  // 로그인된 유저
  User? loggedUser;

  // initstate 함수
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  // 현재 유저 정보를 가져오는 함수
  void getCurrentUser() async {
    try {
      if (user != null) {
        loggedUser = user;
        final getUserData =
            await _firestore.collection('UserInfo').doc(user!.uid).get();

        print(user!.email);
        print('환영합니다. ${getUserData.data()!['userName']} 님!');
      }
    } catch (e) {
      print(e);
    }
  }

  // 현재 유저 정보를 불러오는 함수
  _getUserInfo() async {
    var userinfo = await userInfo.doc(currentUid).get();
    return userinfo.data();
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
              backgroundColor:
                  const Color.fromARGB(255, 15, 15, 15).withOpacity(0.3),
              foregroundColor: Colors.white,
              centerTitle: true,
              title: const Text('Music is Life'),
              actions: [
                IconButton(
                  onPressed: () {},
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
                  child: FutureBuilder(
                    future: _getUserInfo(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 17,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  '${(snapshot.data as Map)['userProfileImage']}',
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

                /// 메인 컬럼
                child: Column(
                  children: [
                    /// 메인 컬럼의 SizedBox
                    const SizedBox(height: 10),

                    /// 메인 컬럼의 두 번째 행
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          InvisibleBoxHot(),
                          SizedBox(width: 15),
                          InvisibleBoxHot(),
                          SizedBox(width: 15),
                          InvisibleBoxHot(),
                          SizedBox(width: 15),
                          InvisibleBoxHot(),
                          SizedBox(width: 15),
                          InvisibleBoxHot(),
                        ],
                      ),
                    ),

                    /// 메인 컬럼 SizedBox
                    const SizedBox(height: 40),

                    /// 메인 컬럼 세 번째 열
                    const Column(
                      children: [
                        Text(
                          'Test',
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

                    /// 로그인 버튼
                    const InvisibleBoxBasic(),

                    const SizedBox(height: 20),

                    /// 메인 컬럼 네 번째 컨테이너 (Invisible)
                    const InvisibleBoxBasic(),

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

                    /// 메인 컬럼 SizedBox
                    const SizedBox(height: 40),

                    /// 메인 컬럼 다섯 번째 열
                    const Column(
                      children: [
                        Text(
                          '3333',
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

                    /// 메인 컬럼 여섯 번째 컨테이너 (Invisible)
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
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey.shade600,
              showUnselectedLabels: false,
              backgroundColor:
                  const Color.fromARGB(255, 15, 15, 15).withOpacity(0.1),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_rounded),
                  label: 'search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.create),
                  label: 'create',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.messenger_outline_rounded),
                  label: 'messenger',
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
