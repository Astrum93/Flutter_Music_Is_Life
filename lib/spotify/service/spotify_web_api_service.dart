import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:music_is_life/main/tab/home/home_fragment.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/spotify_oauth2_client.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

abstract mixin class SpotifyWebApiService {
  final String clientId = dotenv.env['CLIENT_ID'] ?? '';
  final String clientSecret = dotenv.env['CLIENT_SECRET'] ?? '';
  final String redirectUri = dotenv.env['REDIRECT_URI'] ?? '';

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  Future<String> getAccessWebApiToken() async {
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

  Future<String> getAccessToken() async {
    try {
      var authenticationToken = await SpotifySdk.getAccessToken(
          clientId: clientId,
          redirectUrl: redirectUri,
          scope: 'app-remote-control, '
              'user-modify-playback-state, '
              'playlist-read-private, '
              'playlist-modify-public,user-read-currently-playing');
      setStatus('Got a token: $authenticationToken');
      return authenticationToken;
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      setStatus('not implemented');
      return Future.error('not implemented');
    }
  }

  static Future<void> remoteService(BuildContext context) async {
    final String clientId = dotenv.env['CLIENT_ID'] ?? '';
    final String clientSecret = dotenv.env['CLIENT_SECRET'] ?? '';
    final String redirectUri = dotenv.env['REDIRECT_URI'] ?? '';
    AccessTokenResponse? accessToken;
    SpotifyOAuth2Client client = SpotifyOAuth2Client(
      customUriScheme: 'com.example.naspace',
      redirectUri: redirectUri,
    );
    var authResp =
        await client.requestAuthorization(clientId: clientId, customParams: {
      'show_dialog': 'true'
    }, scopes: [
      'user-read-private',
      'user-read-playback-state',
      'user-modify-playback-state',
      'user-read-currently-playing',
      'user-read-email'
    ]);
    var authCode = authResp.code;

    accessToken = await client.requestAccessToken(
        code: authCode.toString(),
        clientId: clientId,
        clientSecret: clientSecret);
    debugPrint('accessToken : $accessToken');
    // Global variables
    String? Access_Token = accessToken.accessToken;
    String? Refresh_Token = accessToken.refreshToken;

    debugPrint('Access_Token : $Access_Token');
    debugPrint('Refresh_Token : $Refresh_Token');
    if (context.mounted) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeFragment()));
    }
  }

  Future<void> connectToSpotifyRemote() async {
    try {
      var result = await SpotifySdk.connectToSpotifyRemote(
          clientId: dotenv.env['CLIENT_ID'].toString(),
          redirectUrl: dotenv.env['REDIRECT_URL'].toString());
      setStatus(result
          ? 'connect to spotify successful'
          : 'connect to spotify failed');
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  /// 기기에 Spotify 앱이 설치 되어 있어야 사용 가능
  playTrack(String trackId) async {
    await SpotifySdk.connectToSpotifyRemote(
        clientId: clientId,
        redirectUrl: "music_is_life://",
        scope:
            "app-remote-control,user-modify-playback-state,playlist-read-private");
    SpotifySdk.play(spotifyUri: "spotify:track:$trackId");
  }

  void setStatus(String code, {String? message}) {
    var text = message ?? '';
    _logger.i('$code$text');
  }
}
