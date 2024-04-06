import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryAll extends StatelessWidget {
  const CategoryAll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('UserContents').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          // 컬렉션의 로그인한 유저의 게시물 문서
          final collectionDocs = snapshot.data!.docs;

          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: collectionDocs.length,
            itemBuilder: (context, index) {
              var doc = collectionDocs[index];
              // Contents Image 있는 문서 참조.
              var contentsImage = doc.get('contentsImage');
              return GridTile(
                child: GestureDetector(
                  onTap: () {},
                  // 보여줄 이미지 사이즈
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.05), width: 1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(18),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(contentsImage),
                      ),
                    ),
                    child: const Text(''),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
