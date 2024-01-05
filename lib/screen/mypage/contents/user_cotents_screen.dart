import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'content_screen.dart';

class UserContentsScreen extends StatefulWidget {
  const UserContentsScreen({super.key});

  @override
  State<UserContentsScreen> createState() => _UserContentsScreenState();
}

class _UserContentsScreenState extends State<UserContentsScreen> {
  // FireStore UserContents collection 참조 변수
  CollectionReference userContentsCollection =
      FirebaseFirestore.instance.collection('UserContents');

  // 현재 인증된 유저 이름
  final _displayName = FirebaseAuth.instance.currentUser!.displayName;

  //
  getUserContents() async {
    var docs = await userContentsCollection.orderBy('$_displayName').get();
    return docs;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userContentsCollection.limit(100).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        // 하위 컬렉션 문서들을 리스트로 표시
        var subCollectionDocs = snapshot.data!.docs;

        // GridView.builder
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = subCollectionDocs[index];

              // Contents Image 있는 문서 참조.
              var title = doc.get('title');
              var contentsImage = doc.get('contentsImage');
              var contents = doc.get('contents');
              var id = doc.get('id');
              var time = doc.get('time');
              var hashTags = doc.get('hashTags');

              // Timestamp를 DateTime으로 변환
              DateTime dateTime = time.toDate();

              // DateTime을 포맷팅
              String formattedDateTime = dateTime.toString();

              return GridTile(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContentsScreen(
                          contentSubject: title,
                          contents: contents,
                          contentsImage: contentsImage,
                          id: id,
                          formattedDateTime: formattedDateTime,
                          hashTags: hashTags,
                        ),
                      ),
                    );
                  },
                  // 보여줄 이미지 사이즈
                  child: Hero(
                    tag: contentsImage,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.05), width: 1),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(contentsImage),
                        ),
                      ),
                      child: const Text(''),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
