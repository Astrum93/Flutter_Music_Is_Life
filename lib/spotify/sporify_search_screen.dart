import 'package:MusicIsLife/common/constant/constants.dart';
import 'package:MusicIsLife/spotify/spotify_search_app_bar.dart';
import 'package:flutter/material.dart';

class SpotifySearchScreen extends StatefulWidget {
  const SpotifySearchScreen({super.key});

  @override
  State<SpotifySearchScreen> createState() => _SpotifySearchScreenState();
}

class _SpotifySearchScreenState extends State<SpotifySearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SpotifySearchAppBar(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 30,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                        child: Image.network(baseProfileImage),
                      ),
                    ),
                    const Text(
                      '음악 제목',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      '가수 이름',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
