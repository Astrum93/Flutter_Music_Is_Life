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
  final _controller = TextEditingController();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  /// FireStore에 저장하는 함수
  Future<void> saveFireStore(
    chatName,
  ) async {
    DateTime now = DateTime.now();
    DateTime hourTimestamp = DateTime(
        now.year, now.month, now.day, now.hour, now.minute, now.microsecond);

    await _fireStore
        .collection('UserChats')
        .doc(chatName)
        .collection('$hourTimestamp')
        .add({
      'sender': user!.displayName,
      'text': _userMessage,
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
    //var member = widget.doc.get('member');
    //var likedMember = widget.doc.get('likedMember');
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
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(
                        child: Text('작성된 메세지가 없습니다.'),
                      );
                    }

                    print(messages);
                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        var message = messages[index];
                        return Text(message['text']);
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
