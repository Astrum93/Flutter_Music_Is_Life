import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naspace/Screen/HomeScreen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  // 로딩 스피너 상태 변수
  bool _loading = false;
//////////////////////////////////         FirebaseAuth           //////////////////////////////////////////////////////

  // Firebase Authentication Instance
  final _authentication = FirebaseAuth.instance;

//////////////////////////////////         Validation           //////////////////////////////////////////////////////

  // Form Key
  final formKey = GlobalKey<FormState>();

  // 회원가입 Value 저장할 변수

  String userMail = '';
  String userPassword = '';

  void tryValidation() {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      formKey.currentState!.save();
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
                    image: AssetImage('lib/Image/Icon/Login.png'),
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
                            TextFormField(
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              key: const ValueKey(1),
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return '올바른 메일을 입력해 주세요.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                userMail = value!;
                              },
                              onChanged: (value) {
                                userMail = value;
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: Colors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35),
                                  ),
                                ),
                                hintText: "메일 주소",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
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
                            TextFormField(
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              key: const ValueKey(2),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 6) {
                                  return '최소 6자리 이상을 입력해주세요.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                userPassword = value!;
                              },
                              onChanged: (value) {
                                userPassword = value;
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock_outline_rounded,
                                  color: Colors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(35),
                                  ),
                                ),
                                hintText: "비밀번호",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),

                            const SizedBox(height: 35),

                            // 체크 버튼
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  _loading = true;
                                });

                                tryValidation();

                                try {
                                  final newUser = await _authentication
                                      .signInWithEmailAndPassword(
                                    email: userMail,
                                    password: userPassword,
                                  );
                                  // User 등록이 됬을 경우
                                  if (newUser.user != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen(),
                                      ),
                                    );
                                    setState(() {
                                      _loading = false;
                                    });
                                  }
                                } catch (e) {
                                  print(e);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        '로그인이 정상적으로 이루어지지 않았습니다.\n입력하신 정보를 확인해 주세요.',
                                        textAlign: TextAlign.center,
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
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
