import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/main/mypage/add_friends/screen/recommend_friends_tab_bar_view.dart';
import 'package:MusicIsLife/main/tab/search/data/search_data.dart';
import 'package:flutter/material.dart';

class RequestFriendDialog extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.veryDarkGrey,
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -80,
              child: RecommendFriendProfileWidget(
                  searchData: searchData, index: index),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                height20,
                Text(
                  data,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                height10,
                const Text(
                  '친구 요청 하시겠습니까?',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),

            /// 친구 요청 버튼
            Positioned(
              right: 0,
              bottom: -50,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.veryDarkGrey,
                    border: Border.all(color: Colors.green)),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                ),
              ),
            ),

            /// 취소 버튼
            Positioned(
              left: 0,
              bottom: -50,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.veryDarkGrey,
                      border: Border.all(color: Colors.redAccent)),
                  child: const Center(
                    child: Icon(
                      Icons.close,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
