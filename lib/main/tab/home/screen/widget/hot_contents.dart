import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/widget/button/hash_tag_text_button.dart';
import 'package:MusicIsLife/data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import 'package:MusicIsLife/data/memory/firebase/firestore/firebase_collection_reference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HotContents extends StatefulWidget {
  const HotContents({super.key});

  @override
  State<HotContents> createState() => _HotContentsState();
}

class _HotContentsState extends State<HotContents>
    with FirebaseCollectionReference, FirebaseAuthUser {
  bool isTouched = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userContentsCollection.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 500,
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Text(
            'No data available',
            style: TextStyle(color: Colors.red),
          );
        }

        // 유저 게시물 컬렉션의 모든 문서
        final contentsDocs = snapshot.data!.docs;

        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 500,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: contentsDocs.length,
            itemBuilder: (context, index) {
              var doc = contentsDocs[index];

              var title = doc.get('title');
              var contentsImage = doc.get('contentsImage');
              var time = doc.get('time');
              var hashTags = doc.get('hashTags');
              var likedMember = doc.get('likedMember');
              var name = doc.get('name');

              // Timestamp를 DateTime으로 변환
              DateTime dateTime = time.toDate();

              // DateTime을 포맷팅
              String formattedDateTime = dateTime.toString();

              return Stack(
                alignment: Alignment.center,
                children: [
                  /// 배경
                  Container(
                    width: 350,
                    height: 500,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 350,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                          color: AppColors.veryDarkGrey,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                    ),
                  ),

                  /// 게시물 사진
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 350,
                      height: 350,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        child: contentsImage.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Image.network(
                                contentsImage,
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                  ),

                  /// 게시물 생성 날짜
                  Positioned(
                    right: 10,
                    bottom: 120,
                    child: Text(
                      formattedDateTime.substring(0, 10),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  /// 게시물 제목
                  Positioned(
                    left: 10,
                    bottom: 110,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.amber,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  /// 프로필 정보
                  Positioned(
                    left: 10,
                    bottom: 50,
                    child: StreamBuilder(
                        stream: userInfoCollection.doc(name).snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }

                          if (!snapshot.hasData || snapshot.data == null) {
                            return const Text(
                              'No data available',
                              style: TextStyle(color: Colors.red),
                            );
                          }

                          // 유저 정보 컬렉션의 모든 문서
                          final userInfoDoc = snapshot.data!;

                          var name = userInfoDoc.get('userName');
                          var profileImage =
                              userInfoDoc.get('userProfileImage');

                          return Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.greenAccent,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    profileImage,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Text(
                              //   '0',
                              //   style: TextStyle(
                              //       color: Colors.grey.shade600,
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 13),
                              // )
                            ],
                          );
                        }),
                  ),

                  /// 좋아요 버튼
                  Positioned(
                    right: 10,
                    bottom: 60,
                    child: IconButton(
                      color: Colors.white,
                      iconSize: 25,
                      onPressed: () {
                        if (!likedMember.contains(user!.displayName)) {
                          userContentsCollection.doc(title).update({
                            'likedMember':
                                FieldValue.arrayUnion([user!.displayName])
                          });
                        }
                        if (likedMember.contains(user!.displayName)) {
                          userContentsCollection.doc(title).update({
                            'likedMember':
                                FieldValue.arrayRemove([user!.displayName])
                          });
                        }
                      },
                      icon: Icon(
                        likedMember.contains(user!.displayName)
                            ? Icons.favorite_outlined
                            : Icons.favorite_border_outlined,
                        color: Colors.pink,
                      ),
                    ),
                  ),

                  /// 좋아요 개수
                  Positioned(
                    right: 28,
                    bottom: 50,
                    child: Text(
                      likedMember.length.toString(),
                      style: TextStyle(
                        color: Colors.pinkAccent.shade100,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  /// HashTags
                  Positioned(
                    bottom: 0,
                    child: Row(
                      children: [
                        HashTagTextButton(
                          onPressed: () {},
                          text: hashTags[0],
                        ),
                        HashTagTextButton(
                          onPressed: () {},
                          text: hashTags[1],
                        ),
                        HashTagTextButton(
                          onPressed: () {},
                          text: hashTags[2],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 20),
          ),
        );
      },
    );
  }
}
