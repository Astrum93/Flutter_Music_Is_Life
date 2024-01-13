import 'dart:convert';

import 'package:MusicIsLife/common/constants.dart';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({
    super.key,
  });

  getMusic() async {
    var url = Uri.parse(
        'https://search.daum.net/search?w=vclip&nil_search=btn&DA=NTB&enc=utf8&q=유튜브+좋은날+아이유+음원');
    http.Response response =
        await http.get(url, headers: {"Accept": "application/json"});

    BeautifulSoup bs = BeautifulSoup(response.body);

    var source = bs.body!.find('a', class_: 'thumb_bf');
    print(source);
    // int i = 0;
    // for (final item in source) {
    //   print("$i 번째 아이템 : $item");
    //   i++;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('$basePath/thumb/Thumb_Test.jpeg'),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(width: 10),
          Expanded(
            child: IconButton(
              onPressed: () {
                getMusic();
              },
              icon: const Icon(
                Icons.play_circle_outline_rounded,
                color: Colors.grey,
                size: 45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
