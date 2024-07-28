import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:music_is_life/common/constant/constants.dart';
import 'package:music_is_life/data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import 'package:music_is_life/data/memory/firebase/firestore/firebase_collection_reference.dart';

class FollowingTabBarView extends StatefulWidget {
  const FollowingTabBarView({super.key});

  @override
  State<FollowingTabBarView> createState() => _FollowingTabBarViewState();
}

class _FollowingTabBarViewState extends State<FollowingTabBarView>
    with FirebaseCollectionReference, FirebaseAuthUser {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userFriendsCollection.doc(displayName).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Text('오류: ${snapshot.error}');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('데이터가 없습니다');
        }

        final userFriendsDoc = snapshot.data!;
        var userFriendsDocData = userFriendsDoc.data() as Map<String, dynamic>?;

        var following = userFriendsDocData != null &&
                userFriendsDocData.containsKey('following')
            ? userFriendsDocData['following']
            : [];

        return ListView.builder(
          itemCount: following.length,
          itemBuilder: (BuildContext context, int index) {
            String userId = following[index];

            return FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('UserInfo')
                  .doc(userId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                if (snapshot.hasError) {
                  return Text('오류: ${snapshot.error}');
                }
                if (snapshot.hasData && snapshot.data!.exists) {
                  String userName =
                      snapshot.data!.data()!.containsKey('userName')
                          ? snapshot.data!.get('userName')
                          : '알 수 없음';
                  String userProfileImage =
                      snapshot.data!.data()!.containsKey('userProfileImage')
                          ? snapshot.data!.get('userProfileImage')
                          : baseProfileImage;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.amberAccent),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 40,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  userProfileImage,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          userName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text('데이터가 없습니다');
                }
              },
            );
          },
        );
      },
    );
  }
}
