import 'package:MusicIsLife/main/tab/lounge/slider_items.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LoungeScreen extends StatefulWidget {
  const LoungeScreen({super.key});

  @override
  State<LoungeScreen> createState() => _LoungeScreenState();
}

class _LoungeScreenState extends State<LoungeScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider(
            items: sliderItems,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                height: 400,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          LoungeSliderIndicator(controller: _controller, current: _current),
          if (_current == 0)
            Container(
              width: 100,
              height: 100,
              color: Colors.green,
            ),
          if (_current == 1)
            Container(
              width: 100,
              height: 100,
              color: Colors.red,
            )
        ],
      ),
    );
  }
}

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
