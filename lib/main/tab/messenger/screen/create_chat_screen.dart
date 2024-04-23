import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/widget/button/check_button.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/main/tab/messenger/chat_widget/chat_widget.dart';
import 'package:MusicIsLife/main/tab/messenger/data/chat_data.dart';
import 'package:MusicIsLife/main/tab/messenger/data/messenger_data.dart';
import 'package:MusicIsLife/main/tab/messenger/screen/friends_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateChatScreen extends StatefulWidget {
  const CreateChatScreen({super.key});

  @override
  State<CreateChatScreen> createState() => _CreateChatScreenState();
}

class _CreateChatScreenState extends State<CreateChatScreen>
    with MessengerDataProvider, ChatDataProvider {
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
                  onTap: () {
                    print(chatData.chatImage);
                    print(chatData.member);
                    print(chatData.chatName);
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
