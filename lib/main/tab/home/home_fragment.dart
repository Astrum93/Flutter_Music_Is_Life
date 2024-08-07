import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_is_life/common/constant/app_colors.dart';
import 'package:music_is_life/common/fcm/fcm_manager.dart';
import 'package:music_is_life/common/widget/button/check_button.dart';
import 'package:music_is_life/common/widget/width_height_widget.dart';
import 'package:music_is_life/main/tab/home/screen/home_screen.dart';
import 'package:music_is_life/main/tab/lounge/lounge_fragment.dart';
import 'package:music_is_life/main/tab/messenger/messenger_fragment.dart';

import '../../../data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import '../../welcome_screen.dart';
import '../search/screen/search_fragment.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> with FirebaseAuthUser {
  int _currentIndex = 0;

  /// Tab Items
  final List<Widget> _tabItems = <Widget>[
    const HomeScreen(),
    const SearchFragment(),
    const LoungeFragment(),
    const MessengerFragment()
  ];

  // initstate 함수
  @override
  void initState() {
    super.initState();
    FcmManager.requestPermission();
    FcmManager.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!didPop) {
          showPopDialog(context);
        }
      },
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SafeArea(
                child: _tabItems.elementAt(_currentIndex),
              ),

              /// Bottom Navigation Bar
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey.shade600,
                showUnselectedLabels: true,
                backgroundColor: Colors.black,
                onTap: (int index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded),
                    label: '홈',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search_rounded),
                    label: '검색',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.multitrack_audio_sharp),
                    label: '라운지',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.messenger_outline_rounded),
                    label: '메신저',
                  ),
                ],
              ),
            );
          }
          return const WelcomeScreen();
        },
      ),
    );
  }

  void showPopDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.redAccent),
                color: AppColors.veryDarkGrey,
              ),
              child: const Center(
                child: Text(
                  '현제 계정에서 \n로그아웃 하시겠습니까?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            height20,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckButton(
                  width: 40,
                  height: 40,
                  boxColor: AppColors.veryDarkGrey,
                  borderColor: Colors.redAccent,
                  icon: Icons.close,
                  iconColor: Colors.redAccent,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Width(150),
                CheckButton(
                  width: 40,
                  height: 40,
                  boxColor: AppColors.veryDarkGrey,
                  borderColor: Colors.greenAccent,
                  icon: Icons.check,
                  iconColor: Colors.greenAccent,
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    if (context.mounted) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()));
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
