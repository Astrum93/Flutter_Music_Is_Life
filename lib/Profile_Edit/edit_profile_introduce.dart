// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naspace/Screen/MyScreen.dart';

class EditProfileIntroduce extends StatefulWidget {
  const EditProfileIntroduce({super.key});

  @override
  State<EditProfileIntroduce> createState() => _nameState();
}

class _nameState extends State<EditProfileIntroduce> {
  // 로딩 스피너 상태 변수
  bool _loading = false;

  // 현재 인증된 유저
  final currentUser = FirebaseAuth.instance.currentUser;

  // Form Key
  final formKey = GlobalKey<FormState>();

  // 회원가입 Value 저장할 변수
  String profileInfo = '';

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Text(
                '프로필 소개 변경',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // 프로필 소개 입력 TextFormField
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(color: Colors.grey),
                ),

                // 입력 창
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  onSaved: (value) {
                    profileInfo = value!;
                  },
                  onChanged: (value) {
                    profileInfo = value;
                  },
                  key: const ValueKey(1),
                  decoration: const InputDecoration(
                    hintText: '내용을 입력해 주세요.',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 닫기 버튼
              TextButton.icon(
                onPressed: () async {
                  setState(() {
                    _loading = true;
                  });

                  try {
                    // Firestore의 UserInfo에 update
                    await FirebaseFirestore.instance
                        .collection('UserInfo')
                        .doc(currentUser!.uid)
                        .update({'userProfileInfo': profileInfo});

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyScreen(),
                      ),
                    );
                    setState(() {
                      _loading = false;
                    });
                  } catch (e) {
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          '프로필이 정상적으로 수정되지 않았습니다.\n입력하신 정보 또는 로그인을 확인해 주세요.',
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.save_alt_rounded),
                label: const Text(
                  'Save',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
