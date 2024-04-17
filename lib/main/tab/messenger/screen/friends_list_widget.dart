import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/main/tab/messenger/data/messenger_data.dart';
import 'package:flutter/material.dart';

class FriendsListWidget extends StatefulWidget {
  const FriendsListWidget({super.key});

  @override
  State<FriendsListWidget> createState() => _FriendsListWidgetState();
}

class _FriendsListWidgetState extends State<FriendsListWidget>
    with MessengerProvider {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              width: 300,
              height: 100,
              color: Colors.amberAccent,
            ),
            height10
          ],
        ),
      ),
    );
  }
}
