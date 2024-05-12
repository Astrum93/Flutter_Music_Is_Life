import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import 'package:MusicIsLife/main/tab/messenger/chat_widget/chat_bubble_widget.dart';
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
  final _controller = TextEditingController();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  /// FireStore에 저장하는 함수
  Future<void> saveFireStore(chatName) async {
    DateTime now = DateTime.now();
    DateTime hourTimestamp = DateTime(
        now.year, now.month, now.day, now.hour, now.minute, now.microsecond);

    DocumentSnapshot userProfileSnapshot = await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(
            user!.displayName) // Assuming user's displayName is the document ID
        .get();

    String? userProfileImage = userProfileSnapshot.get('userProfileImage');

    await _fireStore
        .collection('UserChats')
        .doc(chatName)
        .collection('messages')
        .doc('$hourTimestamp')
        .set({
      'sender': user!.displayName,
      'text': _userMessage,
      'senderProfileImage': userProfileImage,
      'timestamp': Timestamp.fromDate(now),
    });

    setState(() {
      _userMessage = '';
    });

    _controller.clear();

    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    // var chatImage = widget.doc.get('chatImage');
    var chatName = widget.doc.get('chatName');
    // var member = widget.doc.get('member');
    // var likedMember = widget.doc.get('likedMember');
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
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  // image: DecorationImage(
                  //   fit: BoxFit.fill,
                  //   opacity: 0.5,
                  //   image: NetworkImage(chatImage),
                  // ),
                ),
                child: StreamBuilder(
                  stream: _fireStore
                      .collection('UserChats')
                      .doc(chatName)
                      .collection('messages')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    /// error가 발생한 경우
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    /// connectionState가 waiting인 경우
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    /// snapshot에 데이터가 없는 경우
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(
                        child: Text('작성된 메세지가 없습니다.'),
                      );
                    }

                    QuerySnapshot messagesSnapshot = snapshot.data!;
                    List<QueryDocumentSnapshot> messagesDocs =
                        messagesSnapshot.docs;
                    return ListView.builder(
                      itemCount: messagesDocs.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        /// 각 메세지 문서
                        var message = messagesDocs[index];
                        return Column(
                          children: [
                            ChatBubbleWidget(
                              message['text'],
                              message['sender'].toString() == user!.displayName,
                              message['sender'],
                              message['senderProfileImage'],
                            ),
                            height10,
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      cursorColor: Colors.grey,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber)),
                        hintText: '메세지를 입력 해주세요.',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        contentPadding: EdgeInsets.all(4),
                      ),
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
                        : () async {
                            await saveFireStore(chatName);
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
