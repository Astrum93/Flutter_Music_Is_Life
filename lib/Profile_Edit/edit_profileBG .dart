import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:naspace/Screen/MyScreen.dart';

class EditProfileBgImage extends StatefulWidget {
  const EditProfileBgImage({super.key});

  @override
  State<EditProfileBgImage> createState() => _nameState();
}

class _nameState extends State<EditProfileBgImage> {
  // Image 저장 변수
  File? pickedImage;

  // 현재 인증된 유저
  final currentUser = FirebaseAuth.instance.currentUser;

  // Image Picker
  void _pickerImage() async {
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

  // Picked Image 저장
  void _pickedImageSave() async {
    // 클라우드 스토리지 버킷에 경로 생성
    final refImage = FirebaseStorage.instance
        .ref()
        .child('picked_image')
        .child('${currentUser!.uid}_profileBG.png');
    // 클라우드 스토리지 버킷에 저장
    await refImage.putFile(pickedImage!);

    // 저장한 이미지 url로 변환
    final myurl = await refImage.getDownloadURL();

    if (myurl.isNotEmpty) {
      // Firestore의 UserInfo에 저장
      await FirebaseFirestore.instance
          .collection('UserInfo')
          .doc(currentUser!.uid)
          .update({
        'userProfileBgImage': myurl,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: 150,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const Text(
            '프로필 배경 이미지 변경',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),

          // 프로필 이미지
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white,
            backgroundImage:
                pickedImage != null ? FileImage(pickedImage!) : null,
          ),
          const SizedBox(height: 2),

          // 업로드 버튼
          TextButton(
            onPressed: () {
              _pickerImage();
            },
            child: const Text(
              'Upload',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),

          // 닫기 버튼
          TextButton.icon(
            onPressed: () {
              try {
                if (pickedImage != null) {
                  _pickedImageSave();
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyScreen(),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      '이미지가 선택되지 않았습니다.',
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.close),
            label: const Text(
              'Close',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
