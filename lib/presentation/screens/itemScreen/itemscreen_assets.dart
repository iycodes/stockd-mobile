part of "itemscreen.dart";

class MyGenericSlider extends StatefulWidget {
  const MyGenericSlider({super.key});

  @override
  State<MyGenericSlider> createState() => _MyGenericSliderState();
}

class _MyGenericSliderState extends State<MyGenericSlider> {
  late final PageController _pageController;
  late final Timer _carouselTimer;
  // int currentIndex = 0;
  int _pageNo = 0;
  _MyGenericSliderState();
  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
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

  List<_CarouselItem> carouselItems = const [
    _CarouselItem(
        imgSrc:
            "https://img.freepik.com/free-psd/simple-black-men-s-tee-mockup_53876-57893.jpg?w=740&t=st=1694434183~exp=1694434783~hmac=6834af1eb2b0f9b91f91f92fbbf594a423048bde2e1829cb79bec1a0104eb14d"),
    _CarouselItem(
        imgSrc:
            "https://img.freepik.com/free-psd/simple-black-men-s-tee-mockup_53876-57893.jpg?w=740&t=st=1694434183~exp=1694434783~hmac=6834af1eb2b0f9b91f91f92fbbf594a423048bde2e1829cb79bec1a0104eb14d"),
    _CarouselItem(
        imgSrc:
            "https://img.freepik.com/free-psd/simple-black-men-s-tee-mockup_53876-57893.jpg?w=740&t=st=1694434183~exp=1694434783~hmac=6834af1eb2b0f9b91f91f92fbbf594a423048bde2e1829cb79bec1a0104eb14d"),
    _CarouselItem(
        imgSrc:
            "https://img.freepik.com/free-psd/simple-black-men-s-tee-mockup_53876-57893.jpg?w=740&t=st=1694434183~exp=1694434783~hmac=6834af1eb2b0f9b91f91f92fbbf594a423048bde2e1829cb79bec1a0104eb14d")
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
    final devicewidth = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          context.beamToNamed("gallery",
              data: {"currentIndex": _pageNo, "imgs": randomImages});
        },
        child: AspectRatio(
          // width: double.infinity,
          aspectRatio: 1 / 1,
          child: PageView.builder(
            allowImplicitScrolling: true,
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            // pageSnapping: true,
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
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 250),
                  // curve: Curves.decelerate,
                  scale: _pageNo == index ? 1 : 0.9,
                  child: carouselItems[index],
                ),
              );
            },
            itemCount: carouselItems.length,
          ),
        ));
  }

  final BoxDecoration boxDecor = BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade600,
        spreadRadius: 1,
        blurRadius: 18,
        blurStyle: BlurStyle.normal,
        offset: const Offset(0, 2),
      ),
    ],
    borderRadius: BorderRadius.circular(10),
    color: Colors.grey[600],
  );
}

class _CarouselItem extends StatelessWidget {
  final String imgSrc;
  const _CarouselItem({required this.imgSrc});

  @override
  Widget build(BuildContext context) {
    final devicewidth = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: ColoredBox(
        color: Colors.grey,
        child: CachedNetworkImage(
          // fit
          imageUrl: imgSrc,
          placeholder: (context, url) => MyshimmerImage(devicewidth * 0.8),
          cacheManager: CacheManager(
              Config("item_$imgSrc", stalePeriod: const Duration(days: 1))),
        ),
      ),
    );

    // return img;
  }
}

class AddToCartSnackBar extends StatelessWidget {
  const AddToCartSnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SnackBar(
      content: Text("testing snackbar"),
      behavior: SnackBarBehavior.floating,
    );
  }
}

class PhotoGallery extends StatefulWidget {
  final Object data;

  const PhotoGallery(this.data, {super.key});
  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  late final Map dataAsMap = widget.data as Map;
  late final PageController _controller;
  @override
  void initState() {
    _controller = PageController(initialPage: dataAsMap["currentIndex"] as int);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final double deviceHeight = MediaQuery.of(context).size.height;
    final imgs = dataAsMap["imgs"] as List;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.grey,
      ),
      backgroundColor: black,
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PhotoViewGallery.builder(
              itemCount: imgs.length,
              pageController: _controller,
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(
                  imgs[index],
                  cacheKey: imgs[index],
                ));
              }),
          Positioned(
              top: 50,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Beamer.of(context).beamBack();
                    },
                    padding: const EdgeInsets.all(5),
                    icon: const StaticAsset("close", 35),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

const randomImages = [
  "https://img.freepik.com/free-psd/simple-black-men-s-tee-mockup_53876-57893.jpg?w=740&t=st=1694434183~exp=1694434783~hmac=6834af1eb2b0f9b91f91f92fbbf594a423048bde2e1829cb79bec1a0104eb14d",
  "https://img.freepik.com/free-psd/simple-black-men-s-tee-mockup_53876-57893.jpg?w=740&t=st=1694434183~exp=1694434783~hmac=6834af1eb2b0f9b91f91f92fbbf594a423048bde2e1829cb79bec1a0104eb14d",
  "https://img.freepik.com/free-psd/simple-black-men-s-tee-mockup_53876-57893.jpg?w=740&t=st=1694434183~exp=1694434783~hmac=6834af1eb2b0f9b91f91f92fbbf594a423048bde2e1829cb79bec1a0104eb14d",
  "https://img.freepik.com/free-psd/simple-black-men-s-tee-mockup_53876-57893.jpg?w=740&t=st=1694434183~exp=1694434783~hmac=6834af1eb2b0f9b91f91f92fbbf594a423048bde2e1829cb79bec1a0104eb14d",
];

class ColorShower extends StatelessWidget {
  final List<String> colors;
  const ColorShower(this.colors, {super.key});

  @override
  Widget build(BuildContext context) {
    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(100),
    //   child: SizedBox.square(
    //     dimension: 20,
    //     child: ColoredBox(color: HexColor(colors[1])),
    //   ),
    // );
    return Row(
      children: colors
          .map((e) => Padding(
                padding: const EdgeInsets.only(right: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox.square(
                    dimension: 20,
                    child: ColoredBox(color: HexColor(e)),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
