import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:stockd/data/models/item.dart';
import 'package:stockd/presentation/screens/component/ItemCard.dart';
import 'package:stockd/presentation/screens/mainScreen/mainScreen_assets.dart';

const Widget searchIcon = Image(
  image: AssetImage(
    "assets/icons/search.png",
  ),
  width: 25,
);

class MySearchBar extends StatelessWidget {
  final double padding;
  const MySearchBar(this.padding, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: SizedBox(
        height: 30,
        child: TextButton(
            onPressed: () {
              context.beamToNamed("/searchScreen");
            },
            style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                foregroundColor: Colors.grey,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            child: const Row(
              children: [
                StaticAsset("search", 20),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Search Products",
                  style: TextStyle(fontSize: 17, color: Colors.black26),
                ),
              ],
            )),
      ),
    );
  }
}

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                side: BorderSide(
                    style: BorderStyle.solid,
                    width: 2,
                    color: Colors.grey.withOpacity(0.3))),
            child: const Text(
              "Recommended",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoriesTabView extends StatelessWidget {
  final String _text;
  const CategoriesTabView(this._text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(_text),
    );
  }
}

class AnimatedBtn extends StatefulWidget {
  const AnimatedBtn({super.key});

  @override
  State<AnimatedBtn> createState() => _AnimatedBtnState();
}

class _AnimatedBtnState extends State<AnimatedBtn>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = Tween<double>(begin: 0, end: 200).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: animation.value,
      width: animation.value,
      child: const Text("hiiiii"),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class TestingAnimatedWidgets extends StatelessWidget {
  const TestingAnimatedWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeAnimationExample(ElevatedButton(
      child: const Text("heyyy", style: TextStyle(fontSize: 30)),
      onPressed: () {},
    ));
  }
}

class FadeAnimationExample extends StatefulWidget {
  final Widget _child;
  const FadeAnimationExample(this._child, {super.key});
  @override
  State<FadeAnimationExample> createState() => _FadeAnimationExampleState();
}

class _FadeAnimationExampleState extends State<FadeAnimationExample>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ))
    ..forward();
  // ..repeat(reverse: true);
  // ..repeat(reverse: false);
  late final Animation<double> _fadeTransition =
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeTransition,
      child: widget._child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class Xspacer extends StatelessWidget {
  final double _width;
  const Xspacer(this._width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
    );
  }
}

class Yspacer extends StatelessWidget {
  final double _height;
  const Yspacer(this._height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
    );
  }
}

class HomeTabItems extends StatelessWidget {
  HomeTabItems(this._items, {super.key});
  final List<Item> _items;

  late final List _keys = List.generate(_items.length, (index) => GlobalKey());
  @override
  Widget build(BuildContext context) {
    late final deviedWidth = MediaQuery.of(context).size.width;
    late final width = (deviedWidth.toInt() - 40) / 3;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _items.length,

      padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
      // scrollDirection:,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          // mainAxisSpacing: 20,
          crossAxisCount: 3,
          mainAxisExtent: 220),
      itemBuilder: (_, index) => ItemCard(
        itemId: _items[index].id,
        imgSrc: _items[index].thumbnail,
        title: _items[index].name,
        price: _items[index].price,
        discount: "%9",
        width: width,
        key: _keys[index],
      ),
    );
  }
}

List randomItems = [
  randomSrc,
  randomSrc,
  randomSrc,
  randomSrc,
  randomSrc,
  randomSrc
];

const String randomSrc =
    "https://img.freepik.com/free-psd/simple-black-men-s-tee-mockup_53876-57893.jpg?w=740&t=st=1694434183~exp=1694434783~hmac=6834af1eb2b0f9b91f91f92fbbf594a423048bde2e1829cb79bec1a0104eb14d";
const randomTitle = "NIKE SB DUNK LOW";

class HomeTabIcon extends StatelessWidget {
  const HomeTabIcon(this._iconName, this._index, this._currentIndex,
      {super.key});
  final String _iconName;
  final int _index;
  final int _currentIndex;
  @override
  Widget build(BuildContext context) {
    final String path1 = "assets/icons/$_iconName.png";
    final String path2 = "assets/icons/${_iconName}_active.png";

    return Image(
      image: AssetImage(_index == _currentIndex ? path2 : path1),
      width: 20,
    );
  }
}

final List<String> tabNames = [
  "Top",
  "New",
  "Men",
  "Women",
  "Gadgets",
  "Beauty",
  "Homee",
  'Gaming'
];
