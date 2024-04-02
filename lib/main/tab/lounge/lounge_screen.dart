import 'package:MusicIsLife/main/tab/lounge/slider_items.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LoungeScreen extends StatefulWidget {
  const LoungeScreen({super.key});

  @override
  State<LoungeScreen> createState() => _LoungeScreenState();
}

class _LoungeScreenState extends State<LoungeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CarouselSlider(
        items: sliderItems,
        options: CarouselOptions(
          height: 350,
        ),
      ),
    );
  }
}
