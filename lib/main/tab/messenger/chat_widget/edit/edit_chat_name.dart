import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/widget/button/check_button.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/main/tab/messenger/data/chat_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditChatName extends StatefulWidget {
  const EditChatName({super.key});

  @override
  State<EditChatName> createState() => _EditChatNameState();
}

class _EditChatNameState extends State<EditChatName> with ChatDataProvider {
  String? chatName;

  @override
  void initState() {
    Get.put(ChatData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: 250,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const Height(20),
          const Text(
            '채팅방 이름 변경',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Height(20),
          SizedBox(
            width: 200,
            child: TextFormField(
              key: const ValueKey(1),
              keyboardType: TextInputType.text,
              style: const TextStyle(
                color: Colors.white,
              ),
              cursorColor: Colors.amberAccent,
              decoration: const InputDecoration(
                hintText: '채팅방 이름을 입력해 주세요.',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                contentPadding: EdgeInsets.all(10),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onSaved: (value) {
                chatName = value;
              },
            ),
          ),
          const Height(25),
          CheckButton(
            width: 35,
            height: 35,
            borderColor: AppColors.veryDarkGrey,
            icon: Icons.check,
            iconColor: Colors.greenAccent,
            onTap: () {
              chatData.chatName.value = chatName.toString();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
