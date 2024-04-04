import 'package:flutter/material.dart';

import 'join/join_screen.dart';
import 'login/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 메인 Column
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 100,
              child: Image.asset(
                'assets/logo/logo5.png',
                scale: 0.5,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 300,
              child: Image.asset(
                'assets/logo/music_is_life.png',
                scale: 0.5,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 로그인 버튼
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LogInScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "로그인",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 메인 SizedBox
                  const SizedBox(height: 15),

                  // 메인 Column의 회원가입 버튼
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const JoinScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "회원가입",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 메인 SizedBox

                  // 비회원 로그인
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //         builder: (context) => const HomeScreen(),
                  //       ),
                  //     );
                  //   },
                  //   child: const Text(
                  //     "비회원 로그인",
                  //     style: TextStyle(color: Colors.grey),
                  //   ),
                  // ),
                  // Text(
                  //   '현재 로그인된 유저는 $_currentUser 입니다.',
                  //   style: const TextStyle(color: Colors.white),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
