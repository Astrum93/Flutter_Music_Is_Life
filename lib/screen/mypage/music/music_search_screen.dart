import 'package:MusicIsLife/common/widget/search_music.dart';
import 'package:flutter/material.dart';

class MusicSearchScreen extends StatefulWidget {
  const MusicSearchScreen({super.key});

  @override
  State<MusicSearchScreen> createState() => _MusicSearchScreenState();
}

class _MusicSearchScreenState extends State<MusicSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: const Column(
        children: [
          Center(
            child: SearchMusic(),
          ),
        ],
      ),
    );
  }
}
