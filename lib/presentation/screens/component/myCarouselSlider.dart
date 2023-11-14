import 'dart:async';

import 'package:flutter/material.dart';

class MyCarouselSlider extends StatefulWidget {
  const MyCarouselSlider({super.key});

  @override
  State<MyCarouselSlider> createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider> {
  late final PageController _pageController;
  late final Timer _carouselTimer;

  int _pageNo = 0;
  _MyCarouselSliderState();
  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      //  viewportFraction: 0.8
    );
    _carouselTimer = carouselTimer();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _carouselTimer.cancel();
    super.dispose();
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

  Timer carouselTimer() {
    final int carouselLength = carouselItems.length - 1;
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageNo == carouselLength) {
        _pageNo = 0;
      }

      _pageController.animateToPage(_pageNo,
          duration: const Duration(seconds: 1), curve: Curves.decelerate);
      _pageNo++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DecoratedBox(
        decoration: boxDecor,
        child: AspectRatio(
          aspectRatio: 7 / 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ColoredBox(
              // color: myColors.secondary2,
              color: Colors.transparent,
              child: PageView.builder(
                allowImplicitScrolling: true,
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                // physics: BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _pageNo = index;
                  });
                },
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (ctx, child) {
                      return child!;
                    },
                    child: carouselItems[index],
                  );
                },
                itemCount: carouselItems.length,
              ),
            ),
          ),
        ),
      ),
    );
  }

  final BoxDecoration boxDecor = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.grey[600],
  );
}

class CarouselItem extends StatelessWidget {
  final String imgSrc;
  const CarouselItem({super.key, required this.imgSrc});

  @override
  Widget build(BuildContext context) {
    final img = Image.network(
      imgSrc,
      fit: BoxFit.fill,
    );

    return img;
  }
}
