import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naspace/Widget/MusicPlayer.dart';

import '../Widget/ShortContainerLine.dart';

class ContentsScreen extends StatefulWidget {
  final String contents, contents_image, id, formattedDateTime;

  const ContentsScreen(
      {super.key,
      required this.contents,
      required this.contents_image,
      required this.id,
      required this.formattedDateTime});

  @override
  State<ContentsScreen> createState() => _ContentsScreenState();
}

class _ContentsScreenState extends State<ContentsScreen> {
  // Firebase 인증된 uid
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  // FireStore collection 참조 변수
  CollectionReference userInfo =
      FirebaseFirestore.instance.collection('UserInfo');

  // 현재 유저 정보를 불러오는 함수
  _getUserInfo() async {
    var userinfo = await userInfo.doc(_uid).get();
    return userinfo.data();
  }

  // User 정보 불러오기
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserInfo();
    show_more;
  }

  // 좋아요 상태
  var isLiked = false;

  // 좋아요 카운트 변수
  var likecount = 0;

  // 댓글 더보기
  var show_more = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // 유저 정보 FutureBuilder
          FutureBuilder(
            future: _getUserInfo(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ?
                  // 유저 프로필 사진 및 아이디
                  Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // 유저 프로필 사진
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 15,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    '${(snapshot.data as Map)['userProfileImage']}',
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),

                              // 유저 아이디
                              Text(
                                '${(snapshot.data as Map)['userName']}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          // 날짜
                          Row(
                            children: [
                              Text(
                                widget.formattedDateTime.substring(0, 10),
                                style: const TextStyle(color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  : const CircularProgressIndicator();
            },
          ),
          const SizedBox(height: 10),

          // 게시물 이미지
          Hero(
            tag: widget.contents_image,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Image.network(
                widget.contents_image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 음악 플레이어
          const music_player(),

          const SizedBox(height: 15),

          // 콘텐츠 글
          Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            widget.contents,
                            overflow: show_more
                                ? TextOverflow.fade
                                : TextOverflow.visible,
                            maxLines: show_more ? 1 : 100,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // 댓글 더 보기 버튼
                Container(
                  child: Row(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "댓글 더보기",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                show_more = show_more == true ? false : true;
                              });
                              print('test');
                            },
                            icon: show_more
                                ? const Icon(Icons.arrow_drop_down)
                                : const Icon(Icons.arrow_drop_up),
                            color: Colors.grey,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          const shortContainerLine(color: Colors.blue),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
