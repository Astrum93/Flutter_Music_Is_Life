import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_is_life/common/constant/app_colors.dart';
import 'package:music_is_life/common/widget/button/check_button.dart';
import 'package:music_is_life/common/widget/scaffold/custom_snackbar.dart';
import 'package:music_is_life/common/widget/width_height_widget.dart';
import 'package:music_is_life/data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import 'package:music_is_life/main/tab/messenger/chat_widget/chat_widget.dart';
import 'package:music_is_life/main/tab/messenger/chat_widget/friends_list_widget.dart';
import 'package:music_is_life/main/tab/messenger/data/chat_data.dart';

class CreateChatScreen extends StatefulWidget {
  const CreateChatScreen({super.key});

  @override
  State<CreateChatScreen> createState() => _CreateChatScreenState();
}

class _CreateChatScreenState extends State<CreateChatScreen>
    with ChatDataProvider, FirebaseAuthUser {
  @override
  void initState() {
    Get.put(ChatData());
    chatData.getFriendsUserInfo();
    chatData.member.add(user!.displayName.toString());
    chatData.manager.value = user!.email.toString();
    super.initState();
  }

  @override
  void dispose() {
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
              GetBuilder<ChatData>(
                builder: (chatData) {
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
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      } else {
                        CustomSnackBar.buildTopRoundedSnackBar(
                          context,
                          '필요한 정보를 입력 해 주세요.',
                          Colors.redAccent,
                          Colors.white,
                          3,
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        CustomSnackBar.buildTopRoundedSnackBar(
                          context,
                          '알수 없는 오류가 발생 하였습니다.',
                          Colors.grey,
                          Colors.white,
                          3,
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
