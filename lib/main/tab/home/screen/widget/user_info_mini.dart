import 'package:flutter/material.dart';
import 'package:music_is_life/common/constant/app_colors.dart';
import 'package:music_is_life/common/widget/width_height_widget.dart';
import 'package:music_is_life/data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import 'package:music_is_life/data/memory/firebase/firestore/firebase_collection_reference.dart';

class UserInfoMini extends StatefulWidget {
  final String profileImage;
  final String name;
  final String userProfileInfo;

  const UserInfoMini({
    super.key,
    required this.profileImage,
    required this.name,
    required this.userProfileInfo,
  });

  @override
  State<UserInfoMini> createState() => _UserInfoMiniState();
}

class _UserInfoMiniState extends State<UserInfoMini>
    with FirebaseCollectionReference, FirebaseAuthUser {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: 200,
          decoration: const BoxDecoration(
            color: AppColors.veryDarkGrey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          ),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        widget.profileImage,
                      ),
                    ),
                  ),
                  height20,
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Width(20),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      /// 게시글 수
                      Column(
                        children: [
                          const Text(
                            '게시글 수',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          height10,
                          StreamBuilder(
                            stream: userContentsCollection
                                .where("name", isEqualTo: widget.name)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }

                              // 로그인한 유저의 게시물 문서
                              final collectionDocs = snapshot.data!.docs;
                              return Text(
                                collectionDocs.length.toString(),
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              );
                            },
                          ),
                        ],
                      ),
                      width30,

                      /// 팔로잉
                      Column(
                        children: [
                          const Text(
                            '팔로잉',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          height10,
                          Text(
                            '0',
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      width30,

                      /// 팔로워
                      Column(
                        children: [
                          const Text(
                            '팔로워',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          height10,
                          Text(
                            '0',
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                  height20,

                  /// 유저 프로필 소개
                  Expanded(
                    child: Container(
                      width: 220,
                      height: 90,
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: Text(
                          widget.userProfileInfo,
                          textAlign: TextAlign.center,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
