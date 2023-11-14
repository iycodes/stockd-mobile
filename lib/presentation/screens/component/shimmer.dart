import 'package:flutter/material.dart';

class MyShimmerItem extends StatelessWidget {
  const MyShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    final deviedWidth = MediaQuery.of(context).size.width;
    // final myColors = Theme.of(context).extension<MyColors>()!;
    final width = deviedWidth.toInt() / 3.5;
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // OneSidedBoxShadow(width),

          MyshimmerImage(
            width,
            // radius: 10,
          ),
          MyShimmerText(width * 0.7, 8),
          MyShimmerText(width * 0.3, 8)
        ],
      ),
    );
  }
}

class MyshimmerImage extends StatelessWidget {
  final double _width;
  final double radius;
  // static final  _width = Expando<double>();
  // get foo => _width[this];
  const MyshimmerImage(this._width, {this.radius = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: SizedBox(
          width: _width,
          child: const AspectRatio(
            aspectRatio: 3 / 4,
            child: MyShimmer(),
          ),
        ));
  }
}

class SlideTransitionShimmer extends StatefulWidget {
  const SlideTransitionShimmer(this._child, {super.key});
  // final double x1;
  // final double x2;
  final Widget _child;
  @override
  State<SlideTransitionShimmer> createState() => _SlideTransitionShimmerState();
}

class _SlideTransitionShimmerState extends State<SlideTransitionShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500))
    ..repeat(reverse: false, period: const Duration(milliseconds: 1500));

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<Offset> offsetAnimation = Tween<Offset>(
            begin: const Offset(2.5, -0), end: const Offset(-2.5, 0))
        .animate(
            CurvedAnimation(parent: _animController, curve: Curves.decelerate));
    return SlideTransition(
      position: offsetAnimation,
      textDirection: TextDirection.rtl,
      child: widget._child,
    );
  }
}

class MyShimmerText extends StatelessWidget {
  final double width;
  final double height;

  const MyShimmerText(this.width, this.height, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: SizedBox(width: width, height: height, child: const MyShimmer()),
      ),
    );
  }
}

class MyShimmer extends StatelessWidget {
  const MyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey[300]!,
      child: Row(
        children: [
          SlideTransitionShimmer(
            SizedBox(
              width: 30,
              height: 300,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[300]!,
                      spreadRadius: 10,
                      blurRadius: 20),
                  BoxShadow(
                      color: Colors.grey[200]!,
                      offset: const Offset(50, 0),
                      spreadRadius: 10,
                      blurRadius: 20),
                  BoxShadow(
                      color: Colors.grey[300]!,
                      spreadRadius: 10,
                      offset: const Offset(100, 0),
                      blurRadius: 20),
                  BoxShadow(
                      color: Colors.grey[200]!,
                      spreadRadius: 10,
                      offset: const Offset(150, 0),
                      blurRadius: 20)
                ],
              )),
            ),
          )
        ],
      ),
    );
  }
}
