import 'package:MusicIsLife/common/widget/width_height_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: ListView.builder(
          itemCount: messengerData.friendsUserInfoDocs.length,
          itemBuilder: (context, index) => Column(
            children: [
              Container(
                width: 300,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.amberAccent,
                ),
                child: Text(
                    messengerData.friendsUserInfoDocs[index].get('userName')),
              ),
              height10
            ],
          ),
        ),
      ),
    );
  }
}
