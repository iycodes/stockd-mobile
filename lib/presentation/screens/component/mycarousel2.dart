import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stockd/presentation/screens/component/myCarouselSlider.dart';

class MyCarousel2 extends StatefulWidget {
  const MyCarousel2({
    super.key,
  });

  @override
  State<MyCarousel2> createState() => _MyCarousel2State();
}

class _MyCarousel2State extends State<MyCarousel2> {
  _MyCarousel2State();
  int _currentIndex = 0;
  late final PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    carouselTimer();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Timer carouselTimer() {
    final int carouselLength = carouselItems.length - 1;
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex == carouselLength) {
        _currentIndex = 0;
      }

      _pageController.animateToPage(_currentIndex,
          duration: const Duration(seconds: 1), curve: Curves.easeOut);
      _currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final MyColors myColors = Theme.of(context).extension<MyColors>()!;
    return AspectRatio(
      aspectRatio: 7 / 3,
      child: PageView(
          controller: _pageController,
          allowImplicitScrolling: true,
          scrollDirection: Axis.horizontal,
          onPageChanged: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: carouselItems),
    );
  }
}

List<CarouselItem> carouselItems = const [
  CarouselItem(
      imgSrc:
          "https://ng.jumia.is/cms/0-1-weekly-cps/0-2023/w34-home-essential/712x384.jpg"),
  CarouselItem(
      imgSrc:
          "https://ng.jumia.is/cms/0-1-weekly-cps/0-2023/w35-Grocery/Slider_.jpg"),
  CarouselItem(
      imgSrc:
          "https://ng.jumia.is/cms/0-1-weekly-cps/0-2023/w34-home-essential/712x384.jpg"),
  CarouselItem(
      imgSrc:
          "https://ng.jumia.is/cms/0-5-brand-festival/2023/Initiatives/712x384.gif")
];
