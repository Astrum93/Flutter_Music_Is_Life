import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/constant/constants.dart';
import 'package:MusicIsLife/common/widget/button/check_button.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import 'package:MusicIsLife/spotify/data/spotify_search_data.dart';
import 'package:MusicIsLife/spotify/spotify_search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpotifySearchScreenForCreate extends StatefulWidget {
  const SpotifySearchScreenForCreate({super.key});

  @override
  State<SpotifySearchScreenForCreate> createState() =>
      _SpotifySearchScreenForCreateState();
}

class _SpotifySearchScreenForCreateState
    extends State<SpotifySearchScreenForCreate>
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SpotifySearchAppBar(controller: controller),
        body: Obx(
          () => spotifySearchData.searchResult.isEmpty
              ? const Center(
                  child: Text(
                    '스포티파이를 사용하는 검색입니다. \n되도록 영어로 써주세요!',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                )
              : ListView.builder(
                  itemCount: spotifySearchData.searchResult.length,
                  itemBuilder: (context, index) {
                    var track = spotifySearchData.searchResult[index];
                    var trackImage = track['trackImage'] ?? baseProfileImage;
                    var trackName = track['trackName'] ?? '';
                    var artistsName = track['artistsName'] ?? '';
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            debugPrint('on Tap');
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: Container(
                                  width: 100,
                                  height: 300,
                                  decoration: const BoxDecoration(
                                    color: AppColors.veryDarkGrey,
                                  ),
                                  child: Stack(
                                    children: [
                                      const Positioned(
                                        top: 100,
                                        left: 0,
                                        right: 0,
                                        child:
                                            Text('해당 음악 정보를 \n게시물에 추가하시겠습니까?',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                                textAlign: TextAlign.center),
                                      ),

                                      /// 친구 추가 버튼
                                      Positioned(
                                        right: 30,
                                        bottom: 55,
                                        child: CheckButton(
                                          width: 40,
                                          height: 40,
                                          boxColor: AppColors.veryDarkGrey,
                                          borderColor: Colors.greenAccent,
                                          icon: Icons.check,
                                          iconColor: Colors.greenAccent,
                                          onTap: () {},
                                        ),
                                      ),

                                      /// 취소 버튼
                                      Positioned(
                                        left: 0,
                                        bottom: 55,
                                        child: CheckButton(
                                          width: 40,
                                          height: 40,
                                          boxColor: AppColors.veryDarkGrey,
                                          borderColor: Colors.redAccent,
                                          icon: Icons.clear,
                                          iconColor: Colors.redAccent,
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
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
                                      height20,
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        height10,
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
