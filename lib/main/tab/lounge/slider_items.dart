import 'package:flutter/material.dart';

class SliderItem extends StatelessWidget {
  final String path;
  final String text;

  const SliderItem(this.path, {required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          path,
          scale: 1,
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        )
      ],
    );
  }
}

const Widget music1 = SliderItem('assets/image/planet.png', text: 'test1');
const Widget music2 = SliderItem('assets/image/pink_planet.png', text: 'test2');

List<Widget> sliderItems = [music1, music2];
