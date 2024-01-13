import 'package:MusicIsLife/common/constants.dart';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({
    super.key,
  });

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  /// Youtube 주소 가져오는 크롤링 코드
  getMusic() async {
    var url = Uri.parse(
        'https://search.naver.com/search.naver?sm=tab_hty.top&where=video&query==아이유+좋은날+원곡+유튜브');
    http.Response response =
        await http.get(url, headers: {"Accept": "application/json"});

    BeautifulSoup bs = BeautifulSoup(response.body);

    var source = bs.body!.find('a', class_: 'info_title');
    final String youtubeURL = source.toString();
    print(youtubeURL);

    /// 정규식 패턴
    RegExp regExp = RegExp(r'href="([^"]+)"');
    Match? match = regExp.firstMatch(youtubeURL);

    /// Null Safety
    if (match != null) {
      String? result = match.group(1);
      print(result);
    } else {
      print("No matches");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('$basePath/thumb/Thumb_Test.jpeg'),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Let Me Leave You',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '그루비룸 (GroovyRoom), GEMINI (제미나이)',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: IconButton(
              onPressed: () {
                getMusic();
              },
              icon: const Icon(
                Icons.play_circle_outline_rounded,
                color: Colors.grey,
                size: 45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
