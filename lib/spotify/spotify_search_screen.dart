import 'package:MusicIsLife/common/constant/constants.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/spotify/data/spotify_search_data.dart';
import 'package:MusicIsLife/spotify/spotify_search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpotifySearchScreen extends StatefulWidget {
  const SpotifySearchScreen({super.key});

  @override
  State<SpotifySearchScreen> createState() => _SpotifySearchScreenState();
}

class _SpotifySearchScreenState extends State<SpotifySearchScreen>
    with SpotifySearchDataProvider {
  // final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    Get.put(SpotifySearchData());
    // controller.addListener(() {
    //   /// 유저 정보를 검색하는 searchUserInfo 실행
    //   spotifySearchData.searchMusic(controller.text);
    // });
    super.initState();
  }

  @override
  void dispose() {
    /// *** delete는 Generic Type으로 관리 ***
    Get.delete<SpotifySearchData>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SpotifySearchAppBar(),
            spotifySearchData.searchResult.isEmpty
                ? const Text(
                    '스포티파이를 사용하는 검색입니다. \n되도록 영어로 써주세요!',
                    style: TextStyle(color: Colors.redAccent),
                  )
                : Obx(
                    () => Expanded(
                      child: ListView.builder(
                        itemCount: spotifySearchData.searchResult.length,
                        itemBuilder: (context, index) {
                          var track = spotifySearchData.searchResult[index];
                          var trackImage =
                              track['trackImage'] ?? baseProfileImage;
                          var trackName = track['trackName'] ?? '';
                          var artistsName = track['artistsName'] ?? '';
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                width: MediaQuery.of(context).size.width - 10,
                                height: 150,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 30,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                        child: Image.network(trackImage),
                                      ),
                                    ),
                                    Text(
                                      trackName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      artistsName,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              height10,
                            ],
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
