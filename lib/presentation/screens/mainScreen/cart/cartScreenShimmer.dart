import 'package:flutter/material.dart';
import 'package:stockd/presentation/screens/component/myShimmerPage.dart';
import 'package:stockd/presentation/screens/mainScreen/home/home_assets.dart';
import 'package:stockd/presentation/theming/themeExtensions.dart';

class CartScreenShimmer extends StatelessWidget {
  CartScreenShimmer({super.key});
  final colr = Colors.grey[200]!;
  final coll = Colors.black;

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;

    return ColoredBox(
      color: myColors.primary2,
      child: IntrinsicHeight(
        child: SizedBox(
          height: double.infinity,
          child: MyShimmer(
            linearGradient: _shimmerGradient,
            child: ShimmerLoading(
              isLoading: true,
              child: ShaderMask(
                blendMode: BlendMode.srcATop,
                shaderCallback: (bounds) {
                  return _shimmerGradient.createShader(bounds);
                },
                child: const Column(
                  children: [
                    _ItemShimmer(),
                    Yspacer(3),
                    _ItemShimmer(),
                    Yspacer(3),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: Row(
                        children: [
                          // const Text("data"),
                          Expanded(child: _Box()),
                          Xspacer(3),
                          Expanded(child: _Box())
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemShimmer extends StatelessWidget {
  const _ItemShimmer();

  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: Row(
      children: [
        Expanded(child: _Box()),
        Xspacer(3),
        Expanded(
            child: ColoredBox(
          color: Colors.transparent,
          child: SizedBox.expand(
            child: Column(
              children: [
                Yspacer(20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 22,
                    // width: double.infinity,
                    child: _Box(),
                  ),
                ),
                Yspacer(10),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 80),
                  child: SizedBox(
                    height: 22,
                    // width: double.infinity,
                    child: _Box(),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 120),
                  child: SizedBox(
                    height: 22,
                    // width: double.infinity,
                    child: _Box(),
                  ),
                ),
                Yspacer(10)
              ],
            ),
          ),
        ))
      ],
    ));
  }
}

class _Box extends StatelessWidget {
  const _Box();
  static _Box withColor() {
    return const _Box();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: const SizedBox.expand(),
    );
  }
}

final _color = Colors.grey[200]!;
final _shimmerGradient = LinearGradient(
  colors: [
    // Color(0xFFEBEBF4),
    _color,
    const Color(0xFFF9F9F9),
    _color
    // Color(0xFFEBEBF4),
  ],
  stops: const [
    0.1,
    0.3,
    0.4,
  ],
  begin: const Alignment(-1.0, -0.2),
  end: const Alignment(1.0, 0.2),
  tileMode: TileMode.clamp,
);
