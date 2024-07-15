import 'package:flutter/material.dart';
import 'package:music_is_life/main/tab/messenger/screen/create_chat_screen.dart';

class MessengerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MessengerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateChatScreen()),
            );
          },
          icon: const Icon(
            Icons.add,
            color: Colors.grey,
            size: 30,
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, 56.0);
}
