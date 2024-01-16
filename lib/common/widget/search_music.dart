import 'package:MusicIsLife/common/widget/easy_text_form_field.dart';
import 'package:MusicIsLife/common/widget/expanded_box.dart';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SearchMusic extends StatefulWidget {
  const SearchMusic({super.key});

  @override
  State<SearchMusic> createState() => _SearchMusicState();
}

class _SearchMusicState extends State<SearchMusic> {
  String singer = '';
  String titleOfSong = '';
  String youtubeUrl = '';
  String youtubeVideoId = '';
  final String thumbnail = '';
  late YoutubePlayerController youtubeController;

  /// Form Key
  final formKey = GlobalKey<FormState>();

  /// Youtube 주소 가져 오는 크롤링 코드
  Future getMusic(String title, String name) async {
    titleOfSong = title;
    singer = name;
    var searchWord = '$titleOfSong+$singer';
    searchWord = searchWord.replaceAll(' ', '+');
    print(searchWord);

    var url = Uri.parse(
        'https://search.naver.com/search.naver?sm=tab_hty.top&where=video&query=youtube+$searchWord');
    print(url);
    http.Response response =
        await http.get(url, headers: {"Accept": "application/json"});

    BeautifulSoup bs = BeautifulSoup(response.body);

    var source = bs.body!.find('a', class_: 'info_title');
    final String youtubeURL = source.toString();
    print(youtubeURL);

    if (youtubeURL.contains('youtube') == false) {
      print('검색 결과가 youtube 영상이 아닙니다.');
    }

    /// 정규식 패턴
    RegExp regExp = RegExp(r'href="([^"]+)"');
    Match? match = regExp.firstMatch(youtubeURL);

    /// Null Safety
    if (match != null) {
      String result = match.group(1).toString();
      print('result는 $result 입니다.');
      youtubeUrl = result;
    } else {
      print("No matches");
    }
  }

  /// youtube controller 생성
  createYoutubeController(String youtubeUrl) {
    var id = youtubeUrl.substring(32);
    youtubeVideoId = id;
    print('추출된 ID는 $youtubeVideoId 입니다.');

    /// Youtube Player Controller
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: youtubeVideoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    youtubeController = _controller;
    print(youtubeController.initialVideoId);
    print('Controller 생성 완료');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      width: 380,
      height: 430,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 7,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Image.asset(
                'assets/icon/3d_casual_life_cloud_music.png',
                scale: 2,
              ),
              YoutubePlayer(
                controller: youtubeController,
                showVideoProgressIndicator: true,
              ),
              const ExpandedBox(),
              EasyTextFormField(
                  key: const ValueKey(2),
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '노래 제목을 올바르게 입력해 주세요.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    titleOfSong = value!;
                  },
                  onChanged: (value) {
                    titleOfSong = value;
                  },
                  prefixIcon: const Icon(
                    Icons.music_note_rounded,
                    color: Colors.amber,
                  ),
                  hintText: "검색 하실 노래 제목을 입력 해 주세요."),
              const SizedBox(height: 15),
              EasyTextFormField(
                  key: const ValueKey(1),
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '가수 이름을 올바르게 입력해 주세요.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    singer = value!;
                  },
                  onChanged: (value) {
                    singer = value;
                  },
                  prefixIcon: const Icon(
                    Icons.person_search_outlined,
                    color: Colors.amber,
                  ),
                  hintText: "검색 하실 가수 이름을 입력 해 주세요."),
              const ExpandedBox(),
              FloatingActionButton(
                backgroundColor: Colors.greenAccent,
                onPressed: () async {
                  await getMusic(titleOfSong, singer);
                  print('함수 실행으로 가져온 result는 $youtubeUrl 입니다.');
                  await createYoutubeController(youtubeUrl);
                  YoutubePlayer(
                    controller: youtubeController,
                    showVideoProgressIndicator: true,
                    progressColors: ProgressBarColors(),
                  );
                },
                child: const Icon(Icons.search, size: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
