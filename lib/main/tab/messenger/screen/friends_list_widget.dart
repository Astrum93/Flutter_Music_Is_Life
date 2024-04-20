import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/main/mypage/add_friends/friend_profile_widget.dart';
import 'package:MusicIsLife/main/tab/messenger/data/chat_data.dart';
import 'package:MusicIsLife/main/tab/messenger/data/messenger_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendsListWidget extends StatefulWidget {
  const FriendsListWidget({super.key});

  @override
  State<FriendsListWidget> createState() => _FriendsListWidgetState();
}

class _FriendsListWidgetState extends State<FriendsListWidget>
    with MessengerDataProvider {
  final ChatData chatData = ChatData('', '', [], [], 0);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: ListView.builder(
          itemCount: messengerData.friendsUserInfoDocs.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String userName =
                messengerData.friendsUserInfoDocs[index].get('userName');
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (chatData.member.contains(userName)) {
                    chatData.member.remove(userName);
                  } else {
                    chatData.member.add(userName);
                  }
                  print(chatData.member);
                });
              },
              child: Column(
                children: [
                  FriendProfileWidget(
                      rxList: messengerData.friendsUserInfoDocs,
                      index: index,
                      boxColor: Colors.transparent,
                      borderColor: chatData.member.contains(userName)
                          ? Colors.amberAccent
                          : AppColors.veryDarkGrey),
                  height10,
                  Column(
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      height10,
                      Icon(
                        Icons.check_circle_outline_rounded,
                        color: chatData.member.contains(userName)
                            ? Colors.amberAccent
                            : Colors.transparent,
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
