import 'package:flutter/material.dart';
import 'package:music_is_life/common/constant/constants.dart';
import 'package:music_is_life/common/widget/box/hash_tag_box.dart';

import 'expanded_box.dart';

class InvisibleBoxHot extends StatefulWidget {
  const InvisibleBoxHot({
    super.key,
  });

  @override
  State<InvisibleBoxHot> createState() => _InvisibleBoxHotState();
}

class _InvisibleBoxHotState extends State<InvisibleBoxHot> {
  @override
  Widget build(BuildContext context) {
    ThemeData(textTheme: const TextTheme());
    return Builder(builder: (context) {
      return Column(
        children: [
          Row(
            children: [
              Container(
                width: 380,
                height: 480,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 7,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        width: 325,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                            image:
                                AssetImage('$basePath/thumb/Thumb_Test.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Text(''),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Let Me Leave You',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        '그루비룸 (GroovyRoom), GEMINI (제미나이)',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                      '$basePath/profile/pikachu.png'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Pikachu',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '10.3k',
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    color: Colors.white,
                                    iconSize: 25,
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.pink,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: Text(
                                      '19650',
                                      style: TextStyle(
                                        color: Colors.pinkAccent.shade100,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const ExpandedBox(),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          children: [
                            HashTagBox(text: '기분 좋음', width: 5, fontSize: 15),
                            ExpandedBox(),
                            HashTagBox(text: '신남', width: 5, fontSize: 15),
                            ExpandedBox(),
                            HashTagBox(text: '쇼미 11', width: 5, fontSize: 15),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
