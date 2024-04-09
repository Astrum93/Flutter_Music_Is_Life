import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        /// 흰 배경
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: 140,
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
              /// 채팅방 대표 사진
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.grey,
                    size: 40,
                  ),
                ),
              ),
              width20,

              /// 채팅방 이름
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 120,
                        child: Text(
                          '채팅방 이름',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 120,
                    child: Text(
                      '방장 이름',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

        /// 즐겨찾기 버튼
        Positioned(
          top: 10,
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  size: 20,
                ),
                width10,
                Text('0',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),

        /// 하늘색 추가 버튼
        // Positioned(
        //   bottom: -30,
        //   child: Container(
        //     width: 60,
        //     height: 60,
        //     decoration: BoxDecoration(
        //       color: Colors.lightBlue.shade200,
        //       borderRadius: const BorderRadius.all(Radius.circular(20)),
        //     ),
        //     child: const Icon(
        //       Icons.input_rounded,
        //       color: Colors.white,
        //       size: 30,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
