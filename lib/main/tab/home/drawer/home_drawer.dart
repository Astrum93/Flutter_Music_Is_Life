import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_is_life/common/widget/width_height_widget.dart';
import 'package:music_is_life/data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import 'package:music_is_life/data/memory/firebase/firestore/firebase_collection_reference.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer>
    with FirebaseCollectionReference, FirebaseAuthUser {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userInfoCollection.doc(displayName).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Text(
            'No data available',
            style: TextStyle(color: Colors.red),
          );
        }

        final userInfoDoc = snapshot.data!;
        var name = userInfoDoc.get('userName');
        var profileImage = userInfoDoc.get('userProfileImage');
        return Drawer(
          backgroundColor: Colors.black.withOpacity(0.9),
          surfaceTintColor: Colors.black.withOpacity(0.9),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Row(
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 250,
                          height: 250,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),

                        /// User image
                        Positioned(
                          top: -20,
                          left: -20,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(profileImage),
                            ),
                          ),
                        ),

                        /// User ID UI
                        Positioned(
                          top: 20,
                          left: 90,
                          child: Container(
                            width: 140,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 7,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.music_note_rounded,
                                    color: Colors.green,
                                    size: 25,
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        /// 게시글, Liked, Like
                        StreamBuilder(
                            stream: userContentsCollection
                                .where("name", isEqualTo: displayName)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              if (!snapshot.hasData || snapshot.data == null) {
                                return const Text(
                                  'No data available',
                                  style: TextStyle(color: Colors.red),
                                );
                              }

                              /// 컬렉션의 로그인한 유저의 게시물 문서
                              final collectionDocs = snapshot.data!.docs;

                              List allLikedMembers = [];
                              for (var doc in collectionDocs) {
                                var allLikedMember = doc.get('likedMember');
                                allLikedMembers.addAll(allLikedMember);
                              }

                              return Positioned(
                                top: 90,
                                left: 10,
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  width: 240,
                                  height: 100,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 7,
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // 게시글
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                debugPrint(
                                                    allLikedMembers.toString());
                                              },
                                              child: const Text(
                                                '게시글',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              collectionDocs.length.toString(),
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(width: 30),

                                        /// 좋아하는 사람
                                        Column(
                                          children: [
                                            const Text(
                                              'Liked',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "${allLikedMembers.length}",
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 30),

                                        /// 팔로워
                                        StreamBuilder(
                                            stream: userFriendsCollection
                                                .doc(displayName)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }

                                              if (!snapshot.hasData ||
                                                  snapshot.data == null) {
                                                return const Text(
                                                  'No data available',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                );
                                              }

                                              final userFriendsDoc =
                                                  snapshot.data!;
                                              var userFriendsDocData =
                                                  userFriendsDoc.data()
                                                      as Map<String, dynamic>;

                                              var follower = userFriendsDocData
                                                      .containsKey('follower')
                                                  ? userFriendsDocData[
                                                      'follower']
                                                  : [];

                                              return Column(
                                                children: [
                                                  const Text(
                                                    '팔로워',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  height10,
                                                  Text(
                                                    "${follower.length}",
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),

                        // 로그아웃 버튼
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Center(
                            child: TextButton.icon(
                              onPressed: () {
                                // FirebaseAuth signOut
                                FirebaseAuth.instance.signOut();

                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(120, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  backgroundColor:
                                      Colors.grey.withOpacity(0.8)),
                              icon: const Icon(Icons.logout_rounded),
                              label: const Text('Logout'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
