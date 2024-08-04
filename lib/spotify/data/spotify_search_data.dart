import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:music_is_life/spotify/service/spotify_web_api_service.dart';

abstract mixin class SpotifySearchDataProvider {
  /// late 키워드를 사용하는 이유는 state생성이 initState보다 빠르기 때문
  late final spotifySearchData = Get.find<SpotifySearchData>();
}

class SpotifySearchData extends GetxController with SpotifyWebApiService {
  final RxList searchResult = [].obs;
  final RxList selectTrack = [].obs;

  Future searchMusic(String query) async {
    final token = await getAccessWebApiToken();
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/search?q=$query&type=track'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      for (var item in json['tracks']['items']) {
        final String trackImage = item['album']['images'][0]['url'];
        final String trackName = item['name'];
        final String artistsName = item['artists'][0]['name'];
        final String trackId = item['artists'][0]['id'];

        Map<dynamic, dynamic> trackInfo = {
          'trackImage': trackImage,
          'trackName': trackName,
          'artistsName': artistsName,
          'trackId': trackId,
        };
        debugPrint(trackInfo.toString());
        searchResult.add(trackInfo);
      }
      return searchResult;
    } else {
      throw Exception('Failed to search tracks');
    }
  }
}
