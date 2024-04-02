import 'package:flutter/material.dart';

class SliderItem extends StatelessWidget {
  final String path;

  const SliderItem(this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          path,
          scale: 1,
        ),
      ],
    );
  }
}

const Widget music1 = SliderItem('assets/image/planet.png');
const Widget music2 = SliderItem('assets/image/pink_planet.png');

List<Widget> sliderItems = [music1, music2];
