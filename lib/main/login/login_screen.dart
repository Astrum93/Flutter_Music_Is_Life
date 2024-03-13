import 'package:MusicIsLife/common/widget/button/check_button.dart';
import 'package:MusicIsLife/main/tab/home/home_fragment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../common/constants.dart';
import '../../common/widget/easy_text_form_field.dart';
import '../../data/memory/user_join_data.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  // UserData 생성자
  UserJoinData userJoinData = UserJoinData('', '', '', '', '');

  // 로딩 스피너 상태 변수
  bool _loading = false;

//////////////////////////////////         FirebaseAuth           //////////////////////////////////////////////////////

  // Firebase Authentication Instance
  final _auth = FirebaseAuth.instance;

//////////////////////////////////         Validation           //////////////////////////////////////////////////////

  // Form Key
  final formKey = GlobalKey<FormState>();

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  void tryLogin(UserJoinData userData) async {
    final isValied = formKey.currentState!.validate();
    if (isValied) {
      setState(() {
        _loading = true;
      });
      formKey.currentState!.save();
      try {
        final signInUser = await _auth.signInWithEmailAndPassword(
          email: userData.mail,
          password: userData.password,
        );
        // User 등록이 됬을 경우
        if (signInUser.user != null && mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeFragment(),
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
                  '예상치 못한 오류가 발생되어 로그인에 실패하였습니다.',
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
                '등록되지 않은 사용자 입니다.',
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

      // 입력 제외 부분 Tap하면 키보드 사라지게
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 로그인 메인 이미지
                const Center(
                  child: Image(
                    image: AssetImage('$basePath/icon/Login.png'),
                  ),
                ),
                const SizedBox(height: 50),

                // 메인 컨테이너
                Container(
                  decoration: const BoxDecoration(color: Colors.black),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Text(
                                  '이메일',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),

                            // 아이디 입력
                            EasyTextFormField(
                                key: const ValueKey(1),
                                keyboardType: TextInputType.text,
                                obscureText: false,
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return '올바른 메일을 입력해 주세요.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  userJoinData.mail = value!;
                                },
                                onChanged: (value) {
                                  userJoinData.mail = value;
                                },
                                prefixIcon: const Icon(
                                  Icons.mail,
                                  color: Colors.grey,
                                ),
                                hintText: "메일 주소"),
                            const SizedBox(height: 15),

                            const Row(
                              children: [
                                Text(
                                  '비밀번호',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),

                            // 비밀번호 입력
                            EasyTextFormField(
                                key: const ValueKey(2),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 6) {
                                    return '최소 6자리 이상을 입력해주세요.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  userJoinData.password = value!;
                                },
                                onChanged: (value) {
                                  userJoinData.password = value;
                                },
                                prefixIcon: const Icon(
                                  Icons.lock_outline_rounded,
                                  color: Colors.grey,
                                ),
                                hintText: "비밀번호"),
                            const SizedBox(height: 35),

                            // 체크 버튼
                            CheckButton(
                              () async {
                                tryLogin(userJoinData);
                              },
                            )
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
