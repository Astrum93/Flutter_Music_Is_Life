import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/constant/constants.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/spotify/spotify_web_api_service.dart';
import 'package:flutter/material.dart';

class MusicCollectionScreen extends StatefulWidget {
  const MusicCollectionScreen({super.key});

  @override
  State<MusicCollectionScreen> createState() => _MusicCollectionScreenState();
}

class _MusicCollectionScreenState extends State<MusicCollectionScreen> {
  final SpotifyWebApiService spotify = SpotifyWebApiService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('뮤직 리스트'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width - 10,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
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
                ),
                height10,
              ],
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width - 10,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
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
                ),
                height10,
              ],
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width - 10,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
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
                ),
                height10,
              ],
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width - 10,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
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
                ),
                height10,
              ],
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width - 10,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
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
                ),
                height10,
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final musics = await spotify.searchMusic('뱅뱅뱅');
            debugPrint(musics.toString());
          },
          backgroundColor: AppColors.veryDarkGrey,
          splashColor: Colors.amberAccent.withOpacity(0.5),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
