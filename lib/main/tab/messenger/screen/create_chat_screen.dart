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
    with MessengerDataProvider {
  @override
  void initState() {
    Get.put(MessengerData());
    messengerData.getFriendsUserInfo();
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<MessengerData>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
            const Height(60),

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

            /// 친구 목록
            GetBuilder<MessengerData>(
              builder: (messengerData) {
                return const FriendsListWidget();
              },
            ),
            Center(
              child: CheckButton(
                width: 50,
                height: 50,
                icon: Icons.check,
                iconColor: Colors.greenAccent,
                borderColor: AppColors.veryDarkGrey,
                onTap: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
