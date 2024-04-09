import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/main/tab/messenger/chat_widget/chat_widget.dart';
import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Height(30),
        ChatWidget(),
        Height(30),
        ChatWidget(),
        Height(30),
        ChatWidget(),
        Height(30),
        ChatWidget(),
        Height(30),
        ChatWidget(),
        Height(30),
        ChatWidget(),
        Height(30),
        ChatWidget(),
        Height(30),
        ChatWidget(),
        Height(30),
      ],
    );
  }
}
