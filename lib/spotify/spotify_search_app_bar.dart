import 'package:MusicIsLife/spotify/data/spotify_search_data.dart';
import 'package:flutter/material.dart';

class SpotifySearchAppBar extends StatelessWidget
    with SpotifySearchDataProvider
    implements PreferredSizeWidget {
  final TextEditingController controller;

  SpotifySearchAppBar({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  spotifySearchData.searchResult.clear();
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  textInputAction: TextInputAction.done,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber)),
                    hintText: '노래 제목을 입력 해주세요.',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  spotifySearchData.searchResult.clear();
                  spotifySearchData.searchMusic(controller.text);
                },
                child: const Icon(
                  Icons.search_rounded,
                  color: Colors.amberAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, 56.0);
}
