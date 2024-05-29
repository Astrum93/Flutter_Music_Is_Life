import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_sdk/spotify_sdk.dart';

class Spotify {
  final String clientId = dotenv.env['CLIENT_ID'] ?? '';
  final String clientSecret = dotenv.env['CLIENT_SECRET'] ?? '';

  Future<String> getAccessToken() async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'grant_type': 'client_credentials'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['access_token'];
    } else {
      throw Exception('Failed to get access token');
    }
  }

  Future<List<dynamic>> searchMusic(String query) async {
    final token = await getAccessToken();
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/search?q=$query&type=track'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['tracks']['items'];
    } else {
      throw Exception('Failed to search tracks');
    }
  }

  /// 기기에 Spotify 앱이 설치되어 있어야 사용 가능
  playSong() async {
    var res = await SpotifySdk.connectToSpotifyRemote(
        clientId: clientId,
        redirectUrl: "YOUR_APP_NAME://",
        scope:
            "app-remote-control,user-modify-playback-state,playlist-read-private");
    print(res);
    var trackId = "0ct6r3EGTcMLPtrXHDvVjc";
    SpotifySdk.play(spotifyUri: "spotify:track:$trackId");
  }
}
