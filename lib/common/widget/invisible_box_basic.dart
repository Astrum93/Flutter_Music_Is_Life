import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InvisibleBoxBasic extends StatelessWidget {
  InvisibleBoxBasic({super.key});

  getMusic() async {
    var url = Uri.parse(
        "https://www.youtube.com/results?search_query=%EC%9D%B4%EC%86%8C%EB%9D%BC+%EB%B0%94%EB%9E%8C%EC%9D%B4+%EB%B6%84%EB%8B%A4");
    http.Response _response =
        await http.get(url, headers: {"Accept": "application/json"});

    var statusCode = _response.statusCode;
    var _headers = _response.headers;
    var _body = utf8.decode(_response.bodyBytes);

    print("statusCode : $statusCode");
    print("statusHeader : $_headers");
    print("statusBody : $_body");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        getMusic();
      },
      child: Container(
        width: 380,
        height: 380,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 7,
            )
          ],
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                '음악 검색',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
