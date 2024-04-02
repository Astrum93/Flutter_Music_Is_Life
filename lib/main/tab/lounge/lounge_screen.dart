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
        items: <Widget>[
          Image.asset('assets/image/planet.png'),
          Image.asset('assets/image/pink_planet.jpg'),
        ],
        options: CarouselOptions(),
      ),
    );
  }
}
