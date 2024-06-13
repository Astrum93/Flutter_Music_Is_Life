import 'package:MusicIsLife/common/constant/app_colors.dart';
import 'package:MusicIsLife/common/constant/constants.dart';
import 'package:MusicIsLife/common/widget/width_height_widget.dart';
import 'package:MusicIsLife/data/memory/firebase/firebase_auth/firebase_auth_user.dart';
import 'package:MusicIsLife/main/tab/home/data/home_data.dart';
import 'package:MusicIsLife/spotify/spotify_search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

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
                        height10,
                      ],
                    );
                  });
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
