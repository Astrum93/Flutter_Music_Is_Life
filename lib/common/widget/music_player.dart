import 'dart:convert';

import 'package:MusicIsLife/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({
    super.key,
  });

  getMusic() async {
    var url =
        Uri.parse("https://www.youtube.com/results?search_query=이소라+바람이+분다");
    http.Response _response =
        await http.get(url, headers: {"Accept": "application/json"});

    var statusCode = _response.statusCode;
    var _headers = _response.headers;
    var _body = utf8.decode(_response.bodyBytes);

    print("statusCode : $statusCode");
    //print("statusHeader : $_headers");
    print("statusBody : $_body");
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
