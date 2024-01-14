import 'package:MusicIsLife/common/widget/easy_text_form_field.dart';
import 'package:flutter/material.dart';

class SearchMusic extends StatefulWidget {
  const SearchMusic({super.key});

  @override
  State<SearchMusic> createState() => _SearchMusicState();
}

class _SearchMusicState extends State<SearchMusic> {
  String singer = '';
  String titleOfSong = '';

  // Form Key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 200,
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
          child: Column(
            children: [
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
                    singer = value!;
                  },
                  prefixIcon: const Icon(
                    Icons.person_search_outlined,
                    color: Colors.amber,
                  ),
                  hintText: "검색하고자 하는 가수 이름을 써주세요."),
              const SizedBox(height: 15),
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
                    titleOfSong = value!;
                  },
                  prefixIcon: const Icon(
                    Icons.music_note_rounded,
                    color: Colors.amber,
                  ),
                  hintText: "검색하고자 하는 노래 제목을 써주세요."),
            ],
          ),
        ),
      ),
    );
  }
}
