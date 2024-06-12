import 'package:MusicIsLife/common/widget/box/expanded_box.dart';
import 'package:MusicIsLife/common/widget/box/hash_tag_box.dart';
import 'package:MusicIsLife/common/widget/subject_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/short_line.dart';

class ContentsScreen extends StatefulWidget {
  final String contentSubject,
      contents,
      contentsImage,
      id,
      formattedDateTime,
      trackName,
      trackImage,
      artistsName;
  final List hashTags;

  const ContentsScreen({
    super.key,
    required this.contentSubject,
    required this.contents,
    required this.contentsImage,
    required this.id,
    required this.formattedDateTime,
    required this.hashTags,
    required this.trackName,
    required this.trackImage,
    required this.artistsName,
  });

  @override
  State<ContentsScreen> createState() => _ContentsScreenState();
}

class _ContentsScreenState extends State<ContentsScreen> {
  // FireStore collection 참조 변수
  CollectionReference userInfoCollection =
      FirebaseFirestore.instance.collection('UserInfo');

  // 현재 인증된 유저 이름
  final _displayName = FirebaseAuth.instance.currentUser!.displayName;

  // 현재 유저 정보를 불러오는 함수
  _getUserInfo() async {
    var userinfo = await userInfoCollection.doc(_displayName).get();
    return userinfo.data();
  }

  // User 정보 불러오기
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserInfo();
    showMore;
  }

  // 좋아요 상태
  var isLiked = false;

  // 좋아요 카운트 변수
  var likecount = 0;

  // 댓글 더보기
  var showMore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 유저 정보 FutureBuilder
              FutureBuilder(
                future: _getUserInfo(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ?
                      // 유저 프로필 사진 및 아이디
                      Padding(
                          padding: const EdgeInsets.only(left: 4, right: 4),
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
              const SizedBox(height: 20),

              SubjectContainer(text: widget.contentSubject),

              const SizedBox(height: 10),

              // 게시물 이미지
              Hero(
                tag: widget.contentsImage,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.05),
                      width: 1,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Image.network(
                    widget.contentsImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// 음악 정보
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    child: Image.network(
                      widget.trackImage,
                      scale: 6,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.trackName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.artistsName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

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
                                overflow: showMore
                                    ? TextOverflow.fade
                                    : TextOverflow.visible,
                                maxLines: showMore ? 1 : 100,
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
                    Row(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "더보기",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  showMore = showMore == true ? false : true;
                                });
                              },
                              icon: showMore
                                  ? const Icon(Icons.arrow_drop_down)
                                  : const Icon(Icons.arrow_drop_up),
                              color: Colors.grey,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    HashTagBox(
                        text: widget.hashTags[0], width: 10, fontSize: 15),
                    const ExpandedBox(),
                    HashTagBox(
                        text: widget.hashTags[1], width: 10, fontSize: 15),
                    const ExpandedBox(),
                    HashTagBox(
                        text: widget.hashTags[2], width: 10, fontSize: 15),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const ShortLine(color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}
