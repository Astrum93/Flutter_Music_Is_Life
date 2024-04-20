import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/main/tab/messenger/data/chat_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    super.key,
  });

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> with ChatDataProvider {
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
      () => Stack(
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
                borderRadius: BorderRadius.all(Radius.circular(40)),
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
                      color: Colors.black87,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: chatData.chatImage.isEmpty
                        ? const Icon(
                            Icons.add,
                            color: Colors.grey,
                            size: 40,
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 40,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                chatData.chatImage.toString(),
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
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            chatData.chatName.isEmpty
                                ? '채팅방 이름'
                                : chatData.chatName.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 120,
                      child: Text(
                        chatData.member.join(','),
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
                onPressed: () {},
                icon: const Icon(
                  Icons.stars_rounded,
                  color: Colors.grey,
                  size: 30,
                )),
          ),

          /// 채팅방 인원 수
          Positioned(
            right: 40,
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: const BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  Text('${chatData.member.length + 1}',
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
    );
  }
}
