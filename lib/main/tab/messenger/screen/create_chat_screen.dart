import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/widget/button/check_button.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import 'package:MusicIsLife/main/tab/messenger/chat_widget/chat_widget.dart';
import 'package:MusicIsLife/main/tab/messenger/data/chat_data.dart';
import 'package:MusicIsLife/main/tab/messenger/data/messenger_data.dart';
import 'package:MusicIsLife/main/tab/messenger/screen/friends_list_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateChatScreen extends StatefulWidget {
  const CreateChatScreen({super.key});

  @override
  State<CreateChatScreen> createState() => _CreateChatScreenState();
}

class _CreateChatScreenState extends State<CreateChatScreen>
    with MessengerDataProvider, ChatDataProvider, FirebaseAuthUser {
  @override
  void initState() {
    Get.put(MessengerData());
    Get.put(ChatData());
    messengerData.getFriendsUserInfo();
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<MessengerData>();
    Get.delete<ChatData>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              height30,
              const Center(
                child: Text(
                  '새로운 \n채　팅',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50),
                ),
              ),
              const Height(50),
              const Text(
                '* 채팅방 사진과 채팅방 이름을 터치 하여 변경할 수 있습니다.',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              const Height(20),

              /// 채팅방 Widget
              GetBuilder<ChatData>(
                builder: (chatData) {
                  return const ChatWidget();
                },
              ),

              const Height(60),

              const Center(
                child: Text(
                  '친구 목록',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),

              height20,
              const Text(
                '* 채팅방에 추가하고 싶은 친구의 프로필을 선택하여 추가할 수 있습니다.',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              height20,

              /// 친구 목록
              GetBuilder<MessengerData>(
                builder: (messengerData) {
                  return const FriendsListWidget();
                },
              ),

              /// 생성 버튼
              Center(
                child: CheckButton(
                  width: 50,
                  height: 50,
                  icon: Icons.check,
                  iconColor: Colors.greenAccent,
                  borderColor: AppColors.veryDarkGrey,
                  onTap: () async {
                    try {
                      if (chatData.member.isNotEmpty &&
                          chatData.manager.isNotEmpty &&
                          chatData.chatName.isNotEmpty) {
                        chatData.manager.value = user!.email.toString();
                        chatData.member.add(user!.displayName.toString());
                        await FirebaseFirestore.instance
                            .collection('UserChats')
                            .doc(chatData.chatName.toString())
                            .set({
                          'chatImage': chatData.chatImage.toString(),
                          'chatName': chatData.chatName.toString(),
                          'manager': chatData.manager.toString(),
                          'member': chatData.member.toList(),
                          'likedMember': chatData.likedMember.toList(),
                          'createdAt': Timestamp.now(),
                        });
                        if (mounted) {
                          Navigator.of(context).pop();
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                            ),
                            content: Text(
                              '필요한 정보를 입력 해 주세요.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                            ),
                            content: Text(
                              '알수 없는 오류가 발생하였습니다.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
