import 'package:MusicIsLife/main/tab/search/search_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../common/widget/width_height_widget.dart';

class SearchFragment extends StatefulWidget {
  const SearchFragment({super.key});

  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  final TextEditingController controller = TextEditingController();

  Future<void> getDocument() async {
    // 참조할 문서 정의하기
    DocumentReference documentRef =
        FirebaseFirestore.instance.collection('UserContents').doc('david face');

    // 비동기적으로 데이터 호출하기
    DocumentSnapshot documentSnapshot = await documentRef.get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      print(data);
      debugPrint(data['hashTags'].toString()); // 문서 데이터 출력
      debugPrint(data['contents']); // 문서 데이터 출력
      debugPrint(data['name']); // 문서 데이터 출력
    } else {
      print("Document does not exist.");
    }
  }

  Future<void> getCollection() async {
    // 참조할 컬렉션 정의하기
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('UserContents');

    // 비동기적으로 데이터 호출하기
    final QuerySnapshot collectionSnapshot = await collectionRef.get();

    // 컬렉션 데이터에 접근
    for (var doc in collectionSnapshot.docs) {
      // 각 문서의 데이터에 접근
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      print(data['contents']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchAppBar(controller: controller),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height5,
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.red,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.blue,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.green,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.amber,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.red,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.blue,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.green,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.amber,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.red,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.blue,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.green,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
