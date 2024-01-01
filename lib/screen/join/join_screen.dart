import 'package:MusicIsLife/common/widget/check_button.dart';
import 'package:MusicIsLife/common/widget/easy_text_form_field.dart';
import 'package:MusicIsLife/common/widget/google_join_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../common/constants.dart';
import '../../data/memory/firebase/firestore/collection/UserInfo/user_info.dart';
import '../../data/memory/user_join_data.dart';
import '../login/login_screen.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  // UserData 생성자
  final UserJoinData _userJoinData = UserJoinData('', '', '', '', '');

  // 로딩 스피너 상태 변수
  bool _loading = false;

  // Form Key
  final formKey = GlobalKey<FormState>();

  void tryJoin() async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      setState(() {
        _loading = true;
      });
      formKey.currentState!.save();
      try {
        saveUserData(_userJoinData);

        // User 등록이 됬을 경우
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LogInScreen(),
            ),
          );
          setState(() {
            _loading = false;
          });
        } else {
          setState(() {
            _loading = false;
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'firebase에는 입력 됬으나 로그인 화면으로 안넘어감',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } catch (e) {
        setState(() {
          _loading = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                '예상치 못한 오류가 발생 했습니다.',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else {
      setState(() {
        _loading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              '정보를 올바르게 입력해 주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Image(
                    image: const AssetImage('$basePath/icon/vr-headset.png'),
                    // 화면 크기의 -10만큼의 가로 길이
                    width: MediaQuery.of(context).size.width - 10,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.black),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),

                      // Form
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const Center(
                              child: Text(
                                '회원가입',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 15),

                            // 이름
                            EasyTextFormField(
                                key: const ValueKey(1),
                                keyboardType: TextInputType.name,
                                obscureText: false,
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 2) {
                                    return '이름을 입력해 주세요.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _userJoinData.name = value!;
                                },
                                onChanged: (value) {
                                  _userJoinData.name = value;
                                },
                                prefixIcon: const Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                ),
                                hintText: "이름 (ID)"),

                            const SizedBox(height: 15),

                            // 이메일
                            EasyTextFormField(
                                key: const ValueKey(2),
                                keyboardType: TextInputType.emailAddress,
                                obscureText: false,
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return '올바른 메일을 입력해 주세요.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _userJoinData.mail = value!;
                                },
                                onChanged: (value) {
                                  _userJoinData.mail = value;
                                },
                                prefixIcon: const Icon(
                                  Icons.mail,
                                  color: Colors.grey,
                                ),
                                hintText: "메일 주소"),

                            const SizedBox(height: 15),

                            // 비밀번호
                            EasyTextFormField(
                                key: const ValueKey(3),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 6) {
                                    return '최소 6자리 이상을 입력해주세요.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _userJoinData.password = value!;
                                },
                                onChanged: (value) {
                                  _userJoinData.password = value;
                                },
                                prefixIcon: const Icon(
                                  Icons.lock_open_rounded,
                                  color: Colors.grey,
                                ),
                                hintText: "비밀번호"),

                            const SizedBox(height: 15),

                            // 비밀번호 재확인
                            EasyTextFormField(
                                key: const ValueKey(4),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 6) {
                                    return '비밀번호가 일치하지 않습니다.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _userJoinData.passwordCheck = value!;
                                },
                                onChanged: (value) {
                                  _userJoinData.passwordCheck = value;
                                },
                                prefixIcon: const Icon(
                                  Icons.lock_outline_rounded,
                                  color: Colors.grey,
                                ),
                                hintText: "비밀번호 재확인"),

                            const SizedBox(height: 15),

                            // 전화 번호
                            EasyTextFormField(
                                key: const ValueKey(5),
                                keyboardType: TextInputType.phone,
                                obscureText: false,
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('-')) {
                                    return '올바른 휴대전화 번호를 입력해 주세요.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _userJoinData.phone = value!;
                                },
                                onChanged: (value) {
                                  _userJoinData.phone = value;
                                },
                                prefixIcon: const Icon(
                                  Icons.phone_android_rounded,
                                  color: Colors.grey,
                                ),
                                hintText: "전화번호 (000-0000-0000)"),

                            const SizedBox(height: 30),

                            // 회원가입 버튼
                            CheckButton(() async {
                              tryJoin();
                            }),

                            const SizedBox(height: 20),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '또는 SNS 간편 가입',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(height: 30),
                              ],
                            ),

                            // 구글 회원가입 버튼
                            const GoogleJoinButton(),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
