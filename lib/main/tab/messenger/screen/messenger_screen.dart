import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:music_is_life/common/constant/app_colors.dart';
import 'package:music_is_life/common/widget/width_height_widget.dart';
import 'package:music_is_life/data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import 'package:music_is_life/main/tab/messenger/screen/chat_bubble_screen.dart';

class MessengerScreen extends StatefulWidget {
  const MessengerScreen({super.key});

  @override
  State<MessengerScreen> createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen>
    with FirebaseAuthUser {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('UserChats')
          .where('member', arrayContains: user!.displayName)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final List<DocumentSnapshot<Map<String, dynamic>>> collectionDocs =
            snapshot.data!.docs;

        if (collectionDocs.isEmpty) {
          return const Center(
            child: Text(
              '우측 상단의 ➕ 버튼을 눌러 새로운 채팅을 시작해 보세요.',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return Scaffold(
          body: ListView.builder(
            itemCount: collectionDocs.length,
            itemBuilder: (context, index) {
              var doc = collectionDocs[index];
              var chatImage = doc.get('chatImage');
              var chatName = doc.get('chatName');
              var member = doc.get('member');
              var likedMember = doc.get('likedMember');
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChatBubbleScreen(
                            doc: collectionDocs[index],
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        /// 흰 배경
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 140,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                          ),
                        ),

                        /// 채팅방 정보
                        Positioned(
                          top: 20,
                          left: 40,
                          child: Row(
                            children: [
                              /// 채팅방 대표 사진
                              Center(
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    color: AppColors.veryDarkGrey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: chatImage.isEmpty
                                      ? const Icon(
                                          Icons.add,
                                          color: Colors.grey,
                                          size: 40,
                                        )
                                      : CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 40,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.network(
                                              chatImage.toString(),
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center,
                                            ),
                                          ),
                                        ),
                                ),
                              ),

                              width20,

                              /// 채팅방 이름
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // /// 알람 아이콘
                                  // Container(
                                  //   width: 10,
                                  //   height: 10,
                                  //   decoration: const BoxDecoration(
                                  //     color: Colors.grey,
                                  //     borderRadius: BorderRadius.all(Radius.circular(30)),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      chatName.isEmpty
                                          ? '채팅방 이름'
                                          : chatName.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),

                                  /// 채팅 멤버
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      member.isEmpty
                                          ? '채팅 멤버'
                                          : member.join(','),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                        /// 즐겨찾기 버튼
                        Positioned(
                          top: 10,
                          right: 35,
                          child: IconButton(
                            onPressed: () async {
                              if (!likedMember.contains(user!.displayName)) {
                                await FirebaseFirestore.instance
                                    .collection('UserChats')
                                    .doc(chatName)
                                    .update({
                                  'likedMember': FieldValue.arrayUnion(
                                      [user!.displayName]),
                                });
                              }
                              if (likedMember.contains(user!.displayName)) {
                                await FirebaseFirestore.instance
                                    .collection('UserChats')
                                    .doc(chatName)
                                    .update({
                                  'likedMember': FieldValue.arrayRemove(
                                      [user!.displayName]),
                                });
                              }
                            },
                            icon: Icon(
                              Icons.stars_rounded,
                              color: likedMember.contains(user!.displayName)
                                  ? Colors.amberAccent
                                  : Colors.grey,
                              size: 30,
                            ),
                          ),
                        ),

                        /// 채팅방 인원 수
                        Positioned(
                          right: 40,
                          bottom: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: const BoxDecoration(
                              color: Colors.black87,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.people_rounded,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                width10,
                                Text('${member.length}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  height20,
                ],
              );
            },
          ),
        );
      },
    );
  }
}
