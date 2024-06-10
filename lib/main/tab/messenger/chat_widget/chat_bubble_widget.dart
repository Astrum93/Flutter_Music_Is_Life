import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/constant/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatBubbleWidget extends StatefulWidget {
  final String message;
  final String userName;
  final String time;
  final bool isMe;

  const ChatBubbleWidget(this.message, this.isMe, this.userName, this.time,
      {super.key});

  @override
  State<ChatBubbleWidget> createState() => _ChatBubbleWidgetState();
}

class _ChatBubbleWidgetState extends State<ChatBubbleWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('UserInfo')
          .doc(widget.userName)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var userProfileImage = snapshot.data!.get('userProfileImage');
        return Row(
          mainAxisAlignment:
              widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            /// 보내는 사람이 본인인 경우
            if (widget.isMe)
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ChatBubble(
                          clipper:
                              ChatBubbleClipper6(type: BubbleType.sendBubble),
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.only(top: 20),
                          backGroundColor: Colors.blue,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Text(
                              widget.message,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -18,
                          right: 0,
                          child: Text(
                            widget.time,
                            style: TextStyle(
                              color: AppColors.veryDarkGrey.withOpacity(0.7),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.amber),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              userProfileImage ?? baseProfileImage,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        widget.userName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),

            /// 보내는 사람이 본인이 아닌 경우
            if (!widget.isMe)
              Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              userProfileImage ?? baseProfileImage,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        widget.userName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ChatBubble(
                          clipper: ChatBubbleClipper6(
                              type: BubbleType.receiverBubble),
                          backGroundColor: const Color(0xffE7E7ED),
                          margin: const EdgeInsets.only(top: 20),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Text(
                              widget.message,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -18,
                          left: 0,
                          child: Text(
                            widget.time,
                            style: TextStyle(
                              color: AppColors.veryDarkGrey.withOpacity(0.7),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
          ],
        );
      },
    );
  }
}
