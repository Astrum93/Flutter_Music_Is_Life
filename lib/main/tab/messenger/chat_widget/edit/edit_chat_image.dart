import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_is_life/common/constant/app_colors.dart';
import 'package:music_is_life/common/widget/width_height_widget.dart';
import 'package:music_is_life/main/tab/messenger/data/chat_data.dart';

class EditChatImage extends StatefulWidget {
  const EditChatImage({super.key});

  @override
  State<EditChatImage> createState() => _EditChatImageState();
}

class _EditChatImageState extends State<EditChatImage> with ChatDataProvider {
  // Image 저장 변수
  File? pickedImage;
  bool isUploading = false;

  // Image Picker
  void _pickerImage() async {
    setState(() {
      isUploading = true;
    });

    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImageFile != null) {
      pickedImage = File(pickedImageFile.path);
    }
    // 클라우드 스토리지 버킷에 경로 생성
    final refImage = FirebaseStorage.instance
        .ref()
        .child('userChatImage')
        .child('${pickedImage!.uri}_chatImage.png');
    // 클라우드 스토리지 버킷에 저장
    await refImage.putFile(pickedImage!);

    // 저장한 이미지 url로 변환
    final myUrl = await refImage.getDownloadURL();

    if (myUrl.isNotEmpty) {
      chatData.chatImage.value = myUrl;
      setState(() {
        isUploading = false;
      });
    } else {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: 160,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const Height(10),
          const Text(
            '채팅방 이미지 변경',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),

          // 프로필 이미지
          GestureDetector(
            onTap: () {
              _pickerImage();
            },
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: AppColors.veryDarkGrey,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: chatData.chatImage.isEmpty
                      ? const Icon(
                          Icons.add,
                          color: Colors.grey,
                          size: 40,
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              chatData.chatImage.toString(),
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                ),
                if (isUploading)
                  const Positioned(
                    bottom: -50,
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                        strokeWidth: 3,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          height10,
          if (!isUploading)
            // 닫기 버튼
            TextButton.icon(
              onPressed: () {
                try {
                  Navigator.of(context).pop();
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
