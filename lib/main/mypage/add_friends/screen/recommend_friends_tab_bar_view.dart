import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/main/tab/search/data/search_data.dart';
import 'package:flutter/material.dart';

class RecommendsFriendsTabBarView extends StatelessWidget
    with SearchDataProvider {
  RecommendsFriendsTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 150,
      ),
      itemCount: searchData.recommendFriends.length,
      itemBuilder: (context, index) => GestureDetector(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => RequestFriendDialog(
              searchData: searchData,
              index: index,
            ),
          );
        },
        child: Column(
          children: [
            RecommendFriendProfileWidget(searchData: searchData, index: index),
          ],
        ),
      ),
    );
  }
}

class RecommendFriendProfileWidget extends StatelessWidget {
  const RecommendFriendProfileWidget({
    super.key,
    required this.searchData,
    required this.index,
  });

  final SearchData searchData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: (index == 0)
              ? Colors.redAccent
              : (index == 1)
                  ? Colors.blue
                  : (index == 2)
                      ? Colors.greenAccent
                      : AppColors.veryDarkGrey,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              searchData.recommendFriends[index].get('userProfileImage'),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}

class RequestFriendDialog extends StatelessWidget {
  const RequestFriendDialog({
    super.key,
    required this.searchData,
    required this.index,
  });

  final SearchData searchData;
  final int index;

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
                  searchData.recommendFriends[index].get('userName'),
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
