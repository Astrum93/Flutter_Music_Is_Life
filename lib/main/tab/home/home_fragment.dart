import 'package:MusicIsLife/common/fcm/fcm_manager.dart';
import 'package:MusicIsLife/main/tab/home/screen/home_screen.dart';
import 'package:MusicIsLife/main/tab/lounge/lounge_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import '../../welcome_screen.dart';
import '../massenger/massenger_screen.dart';
import '../search/search_screen.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> with FirebaseAuthUser {
  int _currentIndex = 0;

  /// Tap Items
  final List<Widget> _tabItems = <Widget>[
    const HomeScreen(),
    const SearchScreen(),
    const LoungeScreen(),
    const MassengerScreen()
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
    return StreamBuilder(
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
    );
  }
}
