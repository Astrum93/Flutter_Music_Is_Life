import 'package:flutter/material.dart';
import 'package:music_is_life/main/tab/messenger/messenger_app_bar.dart';
import 'package:music_is_life/main/tab/messenger/screen/messenger_screen.dart';

class MessengerFragment extends StatefulWidget {
  const MessengerFragment({super.key});

  @override
  State<MessengerFragment> createState() => _MessengerFragmentState();
}

class _MessengerFragmentState extends State<MessengerFragment> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: MessengerAppBar(),
        body: MessengerScreen(),
      ),
    );
  }
}
