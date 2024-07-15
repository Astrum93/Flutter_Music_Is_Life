import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_is_life/common/widget/width_height_widget.dart';
import 'package:music_is_life/main/tab/lounge/slider/lounge_slider_indicator.dart';
import 'package:music_is_life/main/tab/lounge/slider/slider_items.dart';

import 'category_item/category_all.dart';
import 'category_item/category_current.dart';

class LoungeFragment extends StatefulWidget {
  const LoungeFragment({super.key});

  @override
  State<LoungeFragment> createState() => _LoungeFragmentState();
}

class _LoungeFragmentState extends State<LoungeFragment> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final _displayName = FirebaseAuth.instance.currentUser!.displayName;

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
          height10,
          if (_current == 0) const CategoryAll(),
          if (_current == 1) CategoryCurrent(displayName: _displayName),
        ],
      ),
    );
  }
}
