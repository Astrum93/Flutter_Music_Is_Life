import 'package:MusicIsLife/data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBubbleScreen extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> doc;

  const ChatBubbleScreen({required this.doc, super.key});

  @override
  State<ChatBubbleScreen> createState() => _ChatBubbleScreenState();
}

class _ChatBubbleScreenState extends State<ChatBubbleScreen>
    with FirebaseAuthUser {
  var _userMessage = '';

  @override
  Widget build(BuildContext context) {
    var chatImage = widget.doc.get('chatImage');
    var chatName = widget.doc.get('chatName');
    var member = widget.doc.get('member');
    var likedMember = widget.doc.get('likedMember');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(chatName),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Text(chatName),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _userMessage = value;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: _userMessage.trim().isEmpty
                        ? null
                        : () {
                            FirebaseFirestore.instance
                                .collection('UserChats')
                                .doc(chatName)
                                .collection('Chats')
                                .doc(displayName)
                                .set({
                              'chat': _userMessage,
                              'time': Timestamp.now(),
                            });
                          },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blueAccent,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
