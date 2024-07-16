import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:music_is_life/common/constant/app_colors.dart';
import 'package:music_is_life/common/constant/constants.dart';
import 'package:music_is_life/common/widget/button/check_button.dart';
import 'package:music_is_life/common/widget/width_height_widget.dart';
import 'package:music_is_life/data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import 'package:music_is_life/main/tab/home/data/home_data.dart';
import 'package:music_is_life/spotify/spotify_search_screen.dart';

class MusicCollectionScreen extends StatefulWidget {
  const MusicCollectionScreen({super.key});

  @override
  State<MusicCollectionScreen> createState() => _MusicCollectionScreenState();
}

class _MusicCollectionScreenState extends State<MusicCollectionScreen>
    with FirebaseAuthUser, HomeDataProvider {
  void deleteTrack(int index, String trackName) {
    FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(FirebaseAuth.instance.currentUser!.displayName)
        .collection('UserPlayList')
        .doc(trackName)
        .delete();
    setState(() {});
  }

  Future<void> addProfileTrack(
      String trackImage, String trackName, String artistsName) async {
    await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(FirebaseAuth.instance.currentUser!.displayName)
        .update({
      'userProfileTrackImage': trackImage,
      'userProfileTrackName': trackName,
      'userProfileTrackArtistsName': artistsName,
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('뮤직 리스트'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('UserInfo')
                .doc(FirebaseAuth.instance.currentUser!.displayName)
                .collection('UserPlayList')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              final List<DocumentSnapshot<Map<String, dynamic>>>
                  collectionDocs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: collectionDocs.length,
                itemBuilder: (context, index) {
                  var track = collectionDocs[index];
                  var trackImage = track['trackImage'] ?? baseProfileImage;
                  var trackName = track['trackName'] ?? '';
                  var artistsName = track['artistsName'] ?? '';
                  return Column(
                    children: [
                      Dismissible(
                        key: ValueKey(index),
                        background: Container(
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Width(20),
                              Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                              ),
                              Width(20),
                            ],
                          ),
                        ),
                        onDismissed: (direction) {
                          deleteTrack(index, trackName);
                        },
                        child: GestureDetector(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) => Material(
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        border:
                                            Border.all(color: Colors.redAccent),
                                        color: AppColors.veryDarkGrey,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '현제 음악을 \n프로필 뮤직으로 \n설정 하시겠습니까?',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    height20,
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CheckButton(
                                          width: 40,
                                          height: 40,
                                          boxColor: AppColors.veryDarkGrey,
                                          borderColor: Colors.redAccent,
                                          icon: Icons.close,
                                          iconColor: Colors.redAccent,
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        const Width(150),
                                        CheckButton(
                                          width: 40,
                                          height: 40,
                                          boxColor: AppColors.veryDarkGrey,
                                          borderColor: Colors.greenAccent,
                                          icon: Icons.check,
                                          iconColor: Colors.greenAccent,
                                          onTap: () async {
                                            await addProfileTrack(artistsName,
                                                trackName, trackImage);
                                          },
                                        ),
                                      ],
                                    )
                                  ],
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                  ),
                                                  scrollAxis: Axis.horizontal,
                                                  velocity: 30,
                                                  blankSpace: 40,
                                                ),
                                              )
                                            : Text(
                                                trackName,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                        artistsName.length > 15
                                            ? SizedBox(
                                                width: artistsName.length *
                                                    11.toDouble(),
                                                height: 50,
                                                child: Marquee(
                                                  text: artistsName,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  scrollAxis: Axis.horizontal,
                                                  velocity: 30,
                                                  blankSpace: 40,
                                                ),
                                              )
                                            : Text(
                                                artistsName,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      height10,
                    ],
                  );
                },
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
