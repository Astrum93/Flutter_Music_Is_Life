import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/constant/constants.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import 'package:MusicIsLife/main/tab/home/data/home_data.dart';
import 'package:MusicIsLife/spotify/spotify_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicCollectionScreen extends StatefulWidget {
  const MusicCollectionScreen({super.key});

  @override
  State<MusicCollectionScreen> createState() => _MusicCollectionScreenState();
}

class _MusicCollectionScreenState extends State<MusicCollectionScreen>
    with FirebaseAuthUser, HomeDataProvider {
  @override
  void initState() {
    super.initState();
    Get.put(HomeData());
    homeData.userPlayListCreate();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<HomeData>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('뮤직 리스트'),
          centerTitle: true,
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: homeData.userPlayList.length,
            itemBuilder: (context, index) {
              var track = homeData.userPlayList[index];
              var trackImage = track['trackImage'] ?? baseProfileImage;
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                          child: Image.network(trackImage),
                        ),
                        width30,
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                trackName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
                      ],
                    ),
                  ),
                  height10,
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SpotifySearchScreen()));
          },
          backgroundColor: AppColors.veryDarkGrey,
          splashColor: Colors.amberAccent.withOpacity(0.5),
          child: const Icon(
            Icons.search,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
