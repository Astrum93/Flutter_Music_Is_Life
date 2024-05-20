import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/constants.dart';
import 'package:flutter/material.dart';

class HotContentsMusic extends StatelessWidget {
  const HotContentsMusic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        /// 배경
        Container(
          width: 350,
          height: 500,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          child: Container(
            width: 350,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: AppColors.veryDarkGrey,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
        ),

        /// 음악게시물 사진
        Positioned(
          top: 0,
          child: Container(
            width: 350,
            height: 350,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              child: Image.asset(
                '$basePath/thumb/Thumb_Test.jpeg',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),

        /// 음악 플레이어
        Positioned(
          bottom: 50,
          child: SizedBox(
            width: 350,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Let Me Leave You',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '그루비룸 (GroovyRoom), GEMINI (제미나이)',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.play_circle_outline_rounded,
              color: Colors.grey,
              size: 45,
            ),
          ),
        )
      ],
    );
  }
}
