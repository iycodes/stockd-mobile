import 'package:flutter/material.dart';
import 'package:stockd/presentation/screens/component/myShimmerPage.dart';
import 'package:stockd/presentation/theming/themeExtensions.dart';

class ItemScreenShimmer extends StatelessWidget {
  final bool _isLoading = true;
  const ItemScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return MyShimmer(
      linearGradient: _shimmerGradient,
      child: ShimmerLoading(
        isLoading: true,
        child: ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return _shimmerGradient.createShader(bounds);
          },
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Loading!!!",
                style: TextStyle(fontSize: 50),
              )
            ],
          ),
        ),
      ),
    );
  }
}

const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF9F9F9),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.2),
  end: Alignment(1.0, 0.2),
  tileMode: TileMode.clamp,
);
