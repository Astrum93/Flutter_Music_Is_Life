import 'package:MusicIsLife/data/memory/firebase/firestore/firebase_collection_reference.dart';
import 'package:flutter/material.dart';

import 'button/hash_tag_text_button.dart';

class HotContents extends StatefulWidget {
  const HotContents({super.key});

  @override
  State<HotContents> createState() => _HotContentsState();
}

class _HotContentsState extends State<HotContents>
    with FirebaseCollectionReference {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userContentsCollection.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
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
              var likeCount = doc.get('likeCount').toString();
              var name = doc.get('name');

              // Timestamp를 DateTime으로 변환
              DateTime dateTime = time.toDate();

              // DateTime을 포맷팅
              String formattedDateTime = dateTime.toString();

              return Stack(
                children: [
                  /// 배경
                  Container(
                    width: 350,
                    height: 500,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.05),
                    ),
                  ),

                  /// 게시물 사진
                  Positioned(
                    child: Container(
                      width: 350,
                      height: 350,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(contentsImage),
                          fit: BoxFit.fill,
                        ),
                        color: Colors.grey.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(''),
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

                          // 유저 게시물 컬렉션의 모든 문서
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
                              Text(
                                '10.3k',
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              )
                            ],
                          );
                        }),
                  ),

                  /// 좋아요 버튼과 개수
                  Positioned(
                    right: 10,
                    bottom: 60,
                    child: IconButton(
                      color: Colors.white,
                      iconSize: 25,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.pink,
                      ),
                    ),
                  ),

                  /// 좋아요 개수
                  Positioned(
                    right: 28,
                    bottom: 50,
                    child: Text(
                      likeCount,
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
