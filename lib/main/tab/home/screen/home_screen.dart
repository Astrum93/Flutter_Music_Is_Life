import 'package:MusicIsLife/common/fcm/fcm_manager.dart';
import 'package:MusicIsLife/common/widget/hot_contents.dart';
import 'package:MusicIsLife/common/widget/search_music.dart';
import 'package:MusicIsLife/data/memory/firebase/firestore/firebase_collection_reference.dart';
import 'package:MusicIsLife/main/tab/home/data/home_data.dart';
import 'package:MusicIsLife/main/tab/home/drawer/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import '../../../mypage/mypage_screen.dart';
import '../../search/screen/search_fragment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with FirebaseCollectionReference, FirebaseAuthUser, HomeDataProvider {
  @override
  void initState() {
    Get.put(HomeData());
    homeData.docsProvider();
    FcmManager.requestPermission();
    FcmManager.initialize();
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<HomeData>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: homeData.docsProvider(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const CircularProgressIndicator();
          // }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Music is Life'),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchFragment()));
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
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 17,
                    child: GetBuilder<HomeData>(
                      builder: (homeData) {
                        final loggedUser = homeData.loggedUser;
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: loggedUser.isEmpty
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Image.network(loggedUser['userProfileImage']),
                        );
                      },
                    ),
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
        });
  }
}
