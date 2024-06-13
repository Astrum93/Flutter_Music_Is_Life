import 'package:MusicIsLife/common/constant/constants.dart';
import 'package:MusicIsLife/common/widget/scaffold/custom_snackbar.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import 'package:MusicIsLife/spotify/data/spotify_search_data.dart';
import 'package:MusicIsLife/spotify/spotify_search_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class SpotifySearchScreen extends StatefulWidget {
  const SpotifySearchScreen({super.key});

  @override
  State<SpotifySearchScreen> createState() => _SpotifySearchScreenState();
}

class _SpotifySearchScreenState extends State<SpotifySearchScreen>
    with SpotifySearchDataProvider, FirebaseAuthUser {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    Get.put(SpotifySearchData());
    super.initState();
  }

  @override
  void dispose() {
    /// *** delete는 Generic Type으로 관리 ***
    Get.delete<SpotifySearchData>();
    super.dispose();
  }

  void saveFireStore(trackName, trackImage, artistsName) async {
    try {
      if (user!.displayName!.isNotEmpty &&
          trackName != null &&
          trackImage != null &&
          artistsName != null) {
        await FirebaseFirestore.instance
            .collection('UserInfo')
            .doc(user!.displayName)
            .collection('UserPlayList')
            .doc(trackName)
            .set({
          'trackName': trackName,
          'trackImage': trackImage,
          'artistsName': artistsName,
          'time': DateTime.now(),
        });
        if (mounted) {
          CustomSnackBar.buildTopRoundedSnackBar(
              context, '추가가 완료되었습니다.', Colors.greenAccent, Colors.black, 3);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SpotifySearchAppBar(
              controller: controller,
            ),
            Obx(
              () => spotifySearchData.searchResult.isEmpty
                  ? const Text(
                      '스포티파이를 사용하는 검색입니다. \n되도록 영어로 써주세요!',
                      style: TextStyle(color: Colors.redAccent),
                    )
                  : Expanded(
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            trackName.length > 20
                                                ? SizedBox(
                                                    width: trackName.length *
                                                        11.toDouble(),
                                                    height: 50,
                                                    child: Marquee(
                                                      text: trackName,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                      ),
                                                      scrollAxis:
                                                          Axis.horizontal,
                                                      velocity: 30,
                                                      blankSpace: 40,
                                                    ),
                                                  )
                                                : Text(
                                                    trackName,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                            artistsName.length > 15
                                                ? SizedBox(
                                                    width: artistsName.length *
                                                        11.toDouble(),
                                                    height: 50,
                                                    child: Marquee(
                                                      text: artistsName,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors
                                                            .grey.shade600,
                                                      ),
                                                      scrollAxis:
                                                          Axis.horizontal,
                                                      velocity: 30,
                                                      blankSpace: 40,
                                                    ),
                                                  )
                                                : Text(
                                                    artistsName,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  ),
                                            height20,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    saveFireStore(
                                                        trackName,
                                                        trackImage,
                                                        artistsName);
                                                  },
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: Colors.greenAccent,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
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
            )
          ],
        ),
      ),
    );
  }
}
