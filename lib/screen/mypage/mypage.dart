import 'package:MusicIsLife/common/constants.dart';
import 'package:MusicIsLife/screen/mypage/contents/user_cotents_screen.dart';
import 'package:MusicIsLife/screen/mypage/profile/edit/edit_profile_background%20.dart';
import 'package:MusicIsLife/screen/mypage/profile/edit/edit_profile_image.dart';
import 'package:MusicIsLife/screen/mypage/profile/edit/edit_profile_introduce.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../home/home.dart';
import 'contents/create/create.dart';
import 'contents/create/post.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  // 현재 인증된 유저 이름
  final _displayName = FirebaseAuth.instance.currentUser!.displayName;

  // 컨텐츠 담을 변수
  List allContents = [];

  // FireStore collection 참조 변수
  CollectionReference userInfoCollection =
      FirebaseFirestore.instance.collection('UserInfo');

  // FireStore UserContents collection 참조 변수
  CollectionReference userContentsCollection =
      FirebaseFirestore.instance.collection('UserContents');

  // 현재 유저 정보를 불러오는 함수
  _getUserInfo() async {
    var userInfo = await userInfoCollection.doc(_displayName).get();
    return userInfo.data();
  }

  // Contents 데이터 불러오는 함수
  getContents() async {
    var userContents = await userContentsCollection
        .doc(_displayName)
        .collection('Contents')
        .get();
    return userContents.docs;
  }

  // 이미지 수정 팝업창
  void showAlertProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: EditProfileImage(),
        );
      },
    );
  }

  // 프로필 배경 화면 수정
  void showAlertProfileBackground(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: EditProfileBgImage(),
        );
      },
    );
  }

  // 프로필 소개 수정
  void showAlertProfileIntroduce(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: EditProfileIntroduce(),
        );
      },
    );
  }

  // User 정보 불러오기
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserInfo();
    getContents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
        future: _getUserInfo(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SafeArea(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // 프로필 배경
                              GestureDetector(
                                onTap: () {
                                  showAlertProfileBackground(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          '${(snapshot.data as Map)['userProfileBgImage']}'),
                                    ),
                                  ),
                                  child: const Text(' '),
                                ),
                              ),

                              // 프로필 사진
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: -50,
                                child: GestureDetector(
                                  onTap: () {
                                    showAlertProfile(context);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 50,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        '${(snapshot.data as Map)['userProfileImage']}',
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Home 버튼
                              Positioned(
                                top: 0,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()));
                                  },
                                  icon: const Icon(
                                    Icons.home,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 60),

                        // UserName
                        Text(
                          '${(snapshot.data as Map)['userName']}',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),

                        // 프로필 상호작용 버튼들
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.person_add_alt_1_outlined,
                                color: Colors.green,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.forward_to_inbox_rounded,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.library_music_outlined,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.bolt_rounded,
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // 프로필 소개
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                '📢 프로필 소개',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  showAlertProfileIntroduce(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 10,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blueGrey.shade100
                                            .withOpacity(0.2),
                                        blurRadius: 7,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${(snapshot.data as Map)['userProfileInfo']}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),

                        // 음악 플레이어
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Column(
                            children: [
                              const Text(
                                '🎵 프로필 뮤직',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: MediaQuery.of(context).size.width - 10,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueGrey.shade100
                                          .withOpacity(0.2),
                                      blurRadius: 7,
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.asset(
                                              '$basePath/thumb/Thumb_Test.jpeg'),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Let Me Leave You',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            '그루비룸 (GroovyRoom), GEMINI (제미나이)',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.play_circle_outline_rounded,
                                            color: Colors.grey,
                                            size: 45,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // 게시물 생성 버튼 2개
                        Padding(
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // 게시물 생성 버튼 ( Music recommand )
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PostScreen()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.2),
                                        blurRadius: 7,
                                      )
                                    ],
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.music_note_rounded,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Music recommand',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 25),

                              // Create Contents
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateScreen()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.2),
                                        blurRadius: 7,
                                      )
                                    ],
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.mode_edit_outline_rounded,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Create Contents',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),

                        const Padding(
                          padding: EdgeInsets.only(left: 12, right: 12),
                          child: UserContentsScreen(),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
