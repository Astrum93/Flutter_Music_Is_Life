import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_is_life/common/constant/app_colors.dart';
import 'package:music_is_life/common/widget/width_height_widget.dart';
import 'package:music_is_life/main/mypage/add_friends/friend_profile_widget.dart';
import 'package:music_is_life/main/tab/messenger/data/chat_data.dart';

class FriendsListWidget extends StatefulWidget {
  const FriendsListWidget({super.key});

  @override
  State<FriendsListWidget> createState() => _FriendsListWidgetState();
}

class _FriendsListWidgetState extends State<FriendsListWidget>
    with ChatDataProvider {
  @override
  void initState() {
    Get.put(ChatData());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ChatData>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: ListView.builder(
          itemCount: chatData.friendsUserInfoDocs.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String userName =
                chatData.friendsUserInfoDocs[index].get('userName');
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (chatData.member.contains(userName)) {
                    chatData.member.remove(userName);
                  } else {
                    chatData.member.add(userName);
                  }
                });
              },
              child: Column(
                children: [
                  FriendProfileWidget(
                      rxList: chatData.friendsUserInfoDocs,
                      index: index,
                      boxColor: Colors.transparent,
                      borderColor: chatData.member.contains(userName)
                          ? Colors.amberAccent
                          : AppColors.veryDarkGrey),
                  height10,
                  Text(
                    userName,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
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
