import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:flutter/material.dart';

class CreateChatScreen extends StatelessWidget {
  const CreateChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            height30,
            const Center(
              child: Text(
                '새로운 \n채　팅',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50),
              ),
            ),
            const Height(60),
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                /// 흰 배경
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                  ),
                ),

                /// 채팅방 정보
                Positioned(
                  top: 20,
                  left: 40,
                  child: Row(
                    children: [
                      /// 채팅방 프로필 사진
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                      width20,

                      /// 채팅방 이름
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '채팅방 이름',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '방장 이름',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                /// 즐겨찾기 버튼
                Positioned(
                  top: 0,
                  right: 35,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.stars_rounded,
                        color: Colors.grey,
                        size: 30,
                      )),
                ),

                /// 채팅방 인원 수
                Positioned(
                  right: 40,
                  bottom: 10,
                  child: Container(
                    width: 60,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_rounded,
                          color: Colors.grey,
                          size: 25,
                        ),
                        width10,
                        Text(
                          '0',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                /// 하늘색 추가 버튼
                Positioned(
                  bottom: -30,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Icon(
                      Icons.input_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
