import 'package:flutter/material.dart';
import 'package:stockd/presentation/screens/mainScreen/home/home_assets.dart';
import 'package:stockd/presentation/theming/themeExtensions.dart';

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

class MyShimmerPage extends StatefulWidget {
  MyShimmerPage({
    super.key,
  });
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
  @override
  State<MyShimmerPage> createState() => _MyShimmerPageState();
}

class _MyShimmerPageState extends State<MyShimmerPage> {
  bool _isLoading = true;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  final _color = Colors.grey[200];
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;

    return ColoredBox(
        color: myColors.primary2,
        child: MyShimmer(
          linearGradient: _shimmerGradient,
          child: ShimmerLoading(
            isLoading: true,
            child: ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (bounds) {
                return _shimmerGradient.createShader(bounds);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  const Yspacer(100),
                  // DecoratedBox(
                  //   decoration: BoxDecoration(
                  //       color: Colors.black,
                  //       borderRadius: BorderRadius.circular(3)),
                  //   child: AspectRatio(
                  //     aspectRatio: 3 / 1,
                  //     child: SizedBox(
                  //       width: deviceWidth * 0.5,
                  //       // height: 200,
                  //     ),
                  //   ),
                  // ),
                  // const Yspacer(100),
                  SizedBox(
                    height: 40,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children:
                          widget.tabNames.map((e) => _TabBarItem(e)).toList(),
                    ),
                  ),
                  const Yspacer(5),
                  Flexible(
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          itemCount: randomItems.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 10,
                                  // mainAxisSpacing: 10,
                                  crossAxisCount: 3,
                                  mainAxisExtent: 195),
                          itemBuilder: (context, index) {
                            return const _TabItem();
                          })),
                ],
              ),
            ),
          ),
        ));
  }
}

class MyShimmer extends StatefulWidget {
  static ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerState>();
  }

  const MyShimmer({
    super.key,
    required this.linearGradient,
    this.child,
  });

  final LinearGradient linearGradient;
  final Widget? child;

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<MyShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }
// code-excerpt-closing-bracket

  LinearGradient get gradient => LinearGradient(
        colors: widget.linearGradient.colors,
        stops: widget.linearGradient.stops,
        begin: widget.linearGradient.begin,
        end: widget.linearGradient.end,
        transform:
            _SlidingGradientTransform(slidePercent: _shimmerController.value),
      );

  bool get isSized => (context.findRenderObject() as RenderBox).hasSize;

  Size get size => (context.findRenderObject() as RenderBox).size;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  Listenable get shimmerChanges => _shimmerController;

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Listenable? _shimmerChanges;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = MyShimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {
        // update the shimmer painting.
      });
    }
  }
// code-excerpt-closing-bracket

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    // Collect ancestor shimmer info.
    final shimmer = MyShimmer.of(context)!;
    if (!shimmer.isSized) {
      // The ancestor MyShimmer widget has not laid
      // itself out yet. Return an empty box.
      return const SizedBox();
    }
    final shimmerSize = shimmer.size;
    final gradient = shimmer.gradient;
    final offsetWithinShimmer = shimmer.getDescendantOffset(
      descendant: context.findRenderObject() as RenderBox,
    );

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(
            -offsetWithinShimmer.dx,
            -offsetWithinShimmer.dy,
            shimmerSize.width,
            shimmerSize.height,
          ),
        );
      },
      child: widget.child,
    );
  }
}

//----------- List Items ---------
class CircleListItem extends StatelessWidget {
  const CircleListItem({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        width: 54,
        height: 54,
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.network(
            'https://docs.flutter.dev/cookbook'
            '/img-files/effects/split-check/Avatar1.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _TabBarItem extends StatelessWidget {
  final String txt;
  const _TabBarItem(this.txt);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(7)),
        child: Row(
          children: [
            const Xspacer(20),
            Text(
              txt,
              style: const TextStyle(color: Colors.transparent),
            ),
            const Xspacer(20)
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem();

  @override
  Widget build(BuildContext context) {
    late final deviedWidth = MediaQuery.of(context).size.width;
    late final width = (deviedWidth.toInt() - 40) / 3;
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(7)),
          child: AspectRatio(
            aspectRatio: 3 / 4,
            child: SizedBox(
              width: width,
            ),
          ),
        ),
        const Yspacer(7),
        DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(5)),
          child: SizedBox(
            height: 8,
            width: width,
          ),
        ),
        const Yspacer(3),
        DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(5)),
          child: SizedBox(
            height: 6,
            width: width,
          ),
        )
      ],
    );
  }
}
