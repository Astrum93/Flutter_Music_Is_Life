import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_is_life/common/fcm/fcm_manager.dart';
import 'package:music_is_life/data/memory/firebase/firestore/firebase_collection_reference.dart';
import 'package:music_is_life/main/tab/home/data/home_data.dart';
import 'package:music_is_life/main/tab/home/drawer/home_drawer.dart';
import 'package:music_is_life/main/tab/home/screen/widget/hot_contents.dart';
import 'package:music_is_life/main/tab/home/screen/widget/search_youtube_music.dart';

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
    super.initState();
    Get.put(HomeData());
    homeData.docsProvider();
    FcmManager.requestPermission();
    FcmManager.initialize();
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
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Image.asset(
              'assets/logo/music_is_life.png',
              scale: 8,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SearchFragment(),
                    ),
                  );
                },
                icon: const Icon(Icons.search_rounded),
              ),

              /// 개인 프로필
              GestureDetector(
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
                                child: SizedBox(),
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
                  Text(
                    'Top 10 🔥',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  /// 인기 게시물
                  HotContents(),

                  SizedBox(height: 40),

                  /// 메인 컬럼 세 번째 열
                  Center(
                    child: Text(
                      'Youtube 영상 검색',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  /// 메인 컬럼 SizedBox
                  SizedBox(height: 20),

                  SearchYoutubeMusic(),

                  /// 메인 컬럼 SizedBox
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
