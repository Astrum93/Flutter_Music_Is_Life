import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/widget/button/check_button.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/main/mypage/add_friends/screen/recommend_friends_tab_bar_view.dart';
import 'package:MusicIsLife/main/tab/search/data/search_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RequestFriendDialog extends StatefulWidget {
  const RequestFriendDialog({
    super.key,
    required this.searchData,
    required this.index,
    required this.data,
  });

  final SearchData searchData;
  final int index;
  final String data;

  @override
  State<RequestFriendDialog> createState() => _RequestFriendDialogState();
}

class _RequestFriendDialogState extends State<RequestFriendDialog> {
  void addFriends() async {
    final List friends = [];
    final String user =
        widget.searchData.recommendFriends[widget.index].get('userName');

    final friendSnapshot = await FirebaseFirestore.instance
        .collection('UserFriends')
        .doc(FirebaseAuth.instance.currentUser!.displayName)
        .get();
    final List<dynamic>? existingFriends = friendSnapshot.data()?['friends'];

    try {
      if (friendSnapshot.exists) {
        if (existingFriends != null &&
            existingFriends.contains(user) &&
            mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              content: Text(
                '이미 등록된 사용자 입니다 😂',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              duration: Duration(seconds: 5),
            ),
          );
          if (existingFriends.contains(user) == false && mounted) {
            /// 해당 유저가 친구 리스트에 존재하는 경우
            friends.add(user);
            await FirebaseFirestore.instance
                .collection('UserFriends')
                .doc(FirebaseAuth.instance.currentUser!.displayName)
                .set({'friends': friends});
            if (mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  content: Text(
                    '친구 추가가 성공적으로 처리 되었습니다 🎉',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  duration: Duration(seconds: 5),
                ),
              );
            }
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            content: Text(
              '알수없는 오류로 실행되지 않았습니다.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            duration: Duration(seconds: 5),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: SizedBox(
        width: 300,
        height: 300,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.veryDarkGrey,
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),

            /// 프로필 사진
            Positioned(
              top: 20,
              child: RecommendFriendProfileWidget(
                searchData: widget.searchData,
                index: widget.index,
                borderColor: Colors.amberAccent,
                boxColor: AppColors.veryDarkGrey,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                height20,
                Text(
                  widget.data,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                height10,
                const Text(
                  '친구로 등록 하시겠습니까?',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),

            /// 친구 추가 버튼
            Positioned(
              right: 0,
              bottom: 55,
              child: CheckButton(
                width: 40,
                height: 40,
                boxColor: AppColors.veryDarkGrey,
                borderColor: Colors.greenAccent,
                icon: Icons.check,
                iconColor: Colors.greenAccent,
                onTap: addFriends,
              ),
            ),

            /// 취소 버튼
            Positioned(
              left: 0,
              bottom: 55,
              child: CheckButton(
                width: 40,
                height: 40,
                boxColor: AppColors.veryDarkGrey,
                borderColor: Colors.redAccent,
                icon: Icons.clear,
                iconColor: Colors.redAccent,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
