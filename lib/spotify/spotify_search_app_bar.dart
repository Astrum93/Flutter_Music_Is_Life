import 'package:MusicIsLife/spotify/service/spotify_web_api_service.dart';
import 'package:flutter/material.dart';

class SpotifySearchAppBar extends StatelessWidget
    with SpotifyWebApiServiceDataProvider
    implements PreferredSizeWidget {
  final TextEditingController? controller;

  SpotifySearchAppBar({required this.controller, super.key});

  final SpotifyWebApiService spotifyWebApiService = SpotifyWebApiService();

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
                  spotifyData.searchResult.clear();
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  textInputAction: TextInputAction.search,
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
                  onChanged: (value) {
                    spotifyWebApiService.searchMusic(value);
                  },
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
