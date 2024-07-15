import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:music_is_life/main/tab/lounge/slider/slider_items.dart';

class LoungeSliderIndicator extends StatelessWidget {
  final CarouselController _controller;
  final int _current;

  const LoungeSliderIndicator({
    super.key,
    required CarouselController controller,
    required int current,
  })  : _controller = controller,
        _current = current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: sliderItems.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _controller.animateToPage(entry.key),
          child: Container(
            width: 12.0,
            height: 12.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
                    .withOpacity(_current == entry.key ? 0.9 : 0.4)),
          ),
        );
      }).toList(),
    );
  }
}
