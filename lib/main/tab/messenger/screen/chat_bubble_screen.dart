import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBubbleScreen extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> doc;

  const ChatBubbleScreen({required this.doc, super.key});

  @override
  State<ChatBubbleScreen> createState() => _ChatBubbleScreenState();
}

class _ChatBubbleScreenState extends State<ChatBubbleScreen> {
  @override
  Widget build(BuildContext context) {
    var chatImage = widget.doc.get('chatImage');
    var chatName = widget.doc.get('chatName');
    var member = widget.doc.get('member');
    var likedMember = widget.doc.get('likedMember');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(chatName)),
        body: Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Text(chatName),
        ),
      ),
    );
  }
}
