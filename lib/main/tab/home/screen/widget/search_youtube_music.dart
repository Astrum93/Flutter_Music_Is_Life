import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:music_is_life/common/widget/box/expanded_box.dart';
import 'package:music_is_life/common/widget/easy_text_form_field.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SearchYoutubeMusic extends StatefulWidget {
  const SearchYoutubeMusic({super.key});

  @override
  State<SearchYoutubeMusic> createState() => _SearchYoutubeMusicState();
}

class _SearchYoutubeMusicState extends State<SearchYoutubeMusic> {
  String singer = '';
  String titleOfSong = '';
  String youtubeUrl = '';
  String youtubeVideoId = '';
  final String thumbnail = '';
  late YoutubePlayerController youtubeController;

  /// Form Key
  final formKey = GlobalKey<FormState>();

  /// controller의 initialize 문제 해결할 스위치.
  bool isSearch = false;

  @override
  void initState() {
    isSearch = false;
    super.initState();
  }

  /// Youtube 주소 가져 오는 크롤링 코드
  Future getMusic(String title, String name) async {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      formKey.currentState!.save();

      titleOfSong = title;
      singer = name;
      var searchWord = '$titleOfSong+$singer';
      searchWord = searchWord.replaceAll(' ', '+');
      debugPrint(searchWord);

      var url = Uri.parse(
          'https://search.naver.com/search.naver?sm=tab_hty.top&where=video&query=youtube+$searchWord');
      debugPrint('$url');
      http.Response response =
          await http.get(url, headers: {"Accept": "application/json"});

      BeautifulSoup bs = BeautifulSoup(response.body);

      var source = bs.body!.find('a', class_: 'info_title');
      final String youtubeURL = source.toString();
      debugPrint(youtubeURL);

      if (youtubeURL.contains('youtube') == false) {
        debugPrint('검색 결과가 youtube 영상이 아닙니다.');
      }

      /// 정규식 패턴
      RegExp regExp = RegExp(r'href="([^"]+)"');
      Match? match = regExp.firstMatch(youtubeURL);

      /// Null Safety
      if (match != null) {
        String result = match.group(1).toString();
        debugPrint('result는 $result 입니다.');
        youtubeUrl = result;
      } else {
        debugPrint("No matches");
      }
    }
  }

  /// youtube controller 생성
  createYoutubeController(String youtubeUrl) {
    var id = youtubeUrl.substring(32);
    youtubeVideoId = id;
    debugPrint('추출된 ID는 $youtubeVideoId 입니다.');

    /// Youtube Player Controller
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: youtubeVideoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    youtubeController = controller;
    setState(() {
      isSearch = true;
    });
    debugPrint(youtubeController.initialVideoId);
    debugPrint('Controller 생성 완료');
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
              isSearch
                  ? YoutubePlayer(
                      controller: youtubeController,
                      showVideoProgressIndicator: true,
                    )
                  : Image.asset(
                      'assets/icon/3d_casual_life_cloud_music.png',
                      scale: 2,
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
                  /// 입력된 정보를 바탕으로 web 스크랩핑
                  await getMusic(titleOfSong, singer);

                  debugPrint('함수 실행으로 가져온 result는 $youtubeUrl 입니다.');

                  /// youtube controller로 변환
                  await createYoutubeController(youtubeUrl);
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
