// ignore_for_file: unused_field

import 'dart:io';

import 'package:MusicIsLife/common/widget/button/check_button.dart';
import 'package:MusicIsLife/common/widget/short_line.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/main/mypage/contents/create/spotify_search_screen_for_create.dart';
import 'package:MusicIsLife/spotify/data/spotify_search_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../common/widget/box/hash_tag_input_box.dart';
import '../../mypage_screen.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen>
    with SpotifySearchDataProvider {
// 좋아요 카운트 변수
  final likedMember = [];

  // Firebase 인증된 uid
  final _uid = FirebaseAuth.instance.currentUser!.uid;

  // 현재 인증된 유저
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  // Firebase Storage instance
  final _storage = FirebaseStorage.instance;

  final _store = FirebaseFirestore.instance;

  // 현재 인증된 유저 이름
  final _displayName = FirebaseAuth.instance.currentUser!.displayName;

  // FireStore collection 참조 변수
  CollectionReference userInfoCollection =
      FirebaseFirestore.instance.collection('UserInfo');

  // FireStore UserContents collection 참조 변수
  CollectionReference userContentsCollection =
      FirebaseFirestore.instance.collection('UserContents');

  // Image 저장 변수
  File? pickedImage;

  // Form Key
  final formKey = GlobalKey<FormState>();

  // 게시글 제목 컨트롤러
  final TextEditingController _titleController = TextEditingController();

  // 게시글 내용 컨트롤러
  final TextEditingController _contentController = TextEditingController();

  // 해시태그 내용 컨트롤러
  final TextEditingController _hashtagController1 = TextEditingController();
  final TextEditingController _hashtagController2 = TextEditingController();
  final TextEditingController _hashtagController3 = TextEditingController();

  // 로딩 스피너 상태 변수
  bool _loading = false;

  // 현재 유저 정보를 불러오는 함수
  _getUserInfo() async {
    var userinfo = await userInfoCollection.doc(_displayName).get();
    return userinfo.data();
  }

  // User 정보 불러오기
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(SpotifySearchData());
    _getUserInfo();
  }

  @override
  void dispose() {
    /// *** delete는 Generic Type으로 관리 ***
    Get.delete<SpotifySearchData>();
    super.dispose();
  }

  // 컨텐츠 이미지
  _pickContentsImage() async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxHeight: 300,
    );
    setState(() {
      if (pickedImageFile != null) {
        pickedImage = File(pickedImageFile.path);
      }
    });
  }

  // 이미지 미리보기
  Widget _buildImagePreview() {
    if (pickedImage != null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.blue.shade50.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.file(
          pickedImage!,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.file_upload_outlined,
              color: Colors.blue,
              size: 50,
            ),
            SizedBox(height: 15),
            Text(
              'Select your file',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }
  }

  // 게시글 작성 후 저장
  Future<void> _createContentsAndPost() async {
    if (pickedImage == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('오류'),
            content: const Text('이미지를 선택해주세요.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
      return;
    }

    final title = _titleController.text;
    final content = _contentController.text;
    final hashtag1 = _hashtagController1.text;
    final hashtag2 = _hashtagController2.text;
    final hashtag3 = _hashtagController3.text;
    final List hashTags = [];
    hashTags.addAll([hashtag1, hashtag2, hashtag3]);

    // 클라우드 스토리지 버킷에 경로 생성
    final refContentsImage = _storage
        .ref()
        .child('userContents')
        .child(_displayName!)
        .child(title)
        .child('$title.png');
    await refContentsImage.putFile(pickedImage!);

    // 저장한 이미지 url로 변환
    final myurl = await refContentsImage.getDownloadURL();

    // Firestore의 UserContents 저장
    await userContentsCollection.doc(title).set({
      'name': _displayName,
      'title': title,
      'contentsImage': myurl,
      'contents': content,
      'time': Timestamp.now(),
      'id': _uid,
      'likedMember': likedMember,
      'hashTags': hashTags,
    });

    //작성 완료 후 입력 필드 초기화

    _titleController.clear();
    _contentController.clear();
    _hashtagController1.clear();
    _hashtagController2.clear();
    _hashtagController3.clear();
    setState(() {
      pickedImage = null;
    });
    if (mounted) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: FutureBuilder(
          future: _getUserInfo(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                ),

                                // 프로필 사진
                                Positioned(
                                  top: 30,
                                  left: 10,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 70,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(70),
                                      child: Image.network(
                                        '${(snapshot.data as Map)['userProfileImage']}',
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                ),

                                // 프로필 아이디
                                Positioned(
                                  top: 100,
                                  left: 170,
                                  child: Text(
                                    '${(snapshot.data as Map)['userName']}님',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  top: 140,
                                  left: 170,
                                  child: Text(
                                    '어떤 음악을 추천 받고 싶나요?',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                // 뒤로가기 버튼
                                Positioned(
                                  top: 15,
                                  right: 10,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyScreen()));
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const ShortLine(color: Colors.amber),
                            const SizedBox(height: 10),

                            // 게시물 작성
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '게시물 작성',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const ShortLine(color: Colors.amber),
                            const SizedBox(height: 30),

                            // 게시물 이미지
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // 게시물 이미지 출력
                                GestureDetector(
                                  onTap: () async {
                                    try {
                                      _pickContentsImage();
                                    } catch (e) {
                                      const CircularProgressIndicator();
                                    }
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(10),
                                    dashPattern: const [10, 4],
                                    strokeCap: StrokeCap.round,
                                    color: Colors.white,
                                    child: _buildImagePreview(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // 컨텐츠 내용 입력.
                            Column(
                              children: [
                                // 게시물 제목 입력
                                DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(10),
                                  dashPattern: const [10, 4],
                                  strokeCap: StrokeCap.round,
                                  color: Colors.white,

                                  // 입력 창
                                  child: TextField(
                                    style: const TextStyle(color: Colors.grey),
                                    controller: _titleController,
                                    decoration: const InputDecoration(
                                      hintText: ' 게시물 제목을 입력해 주세요.',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // 게시물 내용 입력
                                DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(10),
                                  dashPattern: const [10, 4],
                                  strokeCap: StrokeCap.round,
                                  color: Colors.white,

                                  // 입력 창
                                  child: TextField(
                                    style: const TextStyle(color: Colors.grey),
                                    controller: _contentController,
                                    decoration: const InputDecoration(
                                      hintText: ' 내용을 입력해 주세요.',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // 해시태그
                                      HashTagInputBox(
                                        text: ' 해시태그',
                                        controller: _hashtagController1,
                                      ),

                                      HashTagInputBox(
                                        text: ' 해시태그',
                                        controller: _hashtagController2,
                                      ),

                                      HashTagInputBox(
                                        text: ' 해시태그',
                                        controller: _hashtagController3,
                                      ),
                                    ],
                                  ),
                                ),

                                const Height(80),
                                const ShortLine(color: Colors.amber),
                                const Height(10),

                                // 게시물 작성
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '게시물 음악 검색',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const Height(10),
                                const ShortLine(color: Colors.amber),
                                const Height(40),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                            const SpotifySearchScreenForCreate()));
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(10),
                                    dashPattern: const [10, 4],
                                    strokeCap: StrokeCap.round,
                                    color: Colors.white,
                                    child: const SpotifySearch(),
                                  ),
                                ),

                                const Height(40),

                                CheckButton(
                                  width: 60,
                                  height: 60,
                                  borderColor: Colors.redAccent,
                                  icon: Icons.check,
                                  iconColor: Colors.white,
                                  iconSize: 40,
                                  onTap: () async {
                                    setState(() {
                                      _loading = true;
                                    });

                                    await _createContentsAndPost();

                                    setState(() {
                                      _loading = false;
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class SpotifySearch extends StatelessWidget {
  const SpotifySearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo/spotify_logo.png',
            scale: 2,
          ),
          height10,
          const Text(
            'Spotify에서 검색하기',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
