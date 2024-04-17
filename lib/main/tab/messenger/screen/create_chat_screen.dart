import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/main/tab/messenger/chat_widget/chat_widget.dart';
import 'package:MusicIsLife/main/tab/messenger/screen/friends_list_widget.dart';
import 'package:flutter/material.dart';

class CreateChatScreen extends StatelessWidget {
  const CreateChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            height30,
            Center(
              child: Text(
                '새로운 \n채　팅',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50),
              ),
            ),
            Height(60),

            /// 채팅방 Widget
            ChatWidget(),

            Height(60),

            /// 친구 목록
            FriendsListWidget(),
          ],
        ),
      ),
    );
  }
}
