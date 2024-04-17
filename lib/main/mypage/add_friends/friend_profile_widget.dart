import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FriendProfileWidget extends StatelessWidget {
  const FriendProfileWidget({
    super.key,
    required this.rxList,
    required this.index,
    required this.boxColor,
    required this.borderColor,
  });

  final RxList rxList;
  final int index;
  final Color? boxColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: boxColor,
          border: Border.all(color: borderColor),
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
              rxList[index].get('userProfileImage').toString(),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
