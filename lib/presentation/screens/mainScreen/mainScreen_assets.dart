import 'package:flutter/material.dart';
import 'package:stockd/presentation/screens/mainScreen/inheritedWidget.dart';

import 'package:stockd/presentation/theming/themeExtensions.dart';

class HomeIcon extends StatelessWidget {
  final bool isDarkmode;
  const HomeIcon(this.isDarkmode, {super.key});
  static const a = Image(
      image: AssetImage(
        "assets/icons/home.png",
      ),
      height: 28);
  static const b = Image(
    image: AssetImage(
      "assets/icons/home.png",
    ),
    height: 28,
  );

  @override
  Widget build(BuildContext context) {
    return isDarkmode ? b : a;
  }
}

class UserIcon extends StatelessWidget {
  final bool isDarkmode;
  const UserIcon(this.isDarkmode, {super.key});
  static const a = Image(
      image: AssetImage(
        "assets/icons/user.png",
      ),
      height: 30);
  static const b = Image(
    image: AssetImage(
      "assets/icons/user.png",
    ),
    height: 30,
  );

  @override
  Widget build(BuildContext context) {
    return isDarkmode ? b : a;
  }
}

// class SavedIcon extends StatelessWidget {
//   final bool isDarkmode;
//   const SavedIcon(this.isDarkmode, {super.key});
//   static const a = Image(
//       image: AssetImage(
//         "assets/icons/saved.png",
//       ),
//       height: 30);
//   static const b = Image(
//     image: AssetImage(
//       "assets/icons/saved.png",
//     ),
//     height: 30,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return isDarkmode ? b : a;
//   }
// }

class BagIcon extends StatelessWidget {
  final bool isDarkmode;
  const BagIcon(this.isDarkmode, {super.key});
  static const a = Image(
      image: AssetImage(
        "assets/icons/bag.png",
      ),
      height: 30);
  static const b = Image(
    image: AssetImage(
      "assets/icons/bag.png",
    ),
    height: 30,
  );

  @override
  Widget build(BuildContext context) {
    return isDarkmode ? b : a;
  }
}

class MoreIcon extends StatelessWidget {
  final bool isDarkmode;
  const MoreIcon(this.isDarkmode, {super.key});
  static const a = Image(
      image: AssetImage(
        "assets/icons/more.png",
      ),
      height: 30);
  static const b = Image(
    image: AssetImage(
      "assets/icons/more.png",
    ),
    height: 30,
  );

  @override
  Widget build(BuildContext context) {
    return isDarkmode ? b : a;
  }
}

class MenuIcon extends StatelessWidget {
  final bool isDarkmode;
  const MenuIcon(this.isDarkmode, {super.key});
  static const a = Image(
      image: AssetImage(
        "assets/icons/menu.png",
      ),
      height: 30);
  static const b = Image(
    image: AssetImage(
      "assets/icons/menu.png",
    ),
    height: 30,
  );

  @override
  Widget build(BuildContext context) {
    return isDarkmode ? b : a;
  }
}

class MainScreenTab extends StatelessWidget {
  final bool _isDarkMode;
  const MainScreenTab(this._isDarkMode, this._name, {super.key});
  final String _name;
  @override
  Widget build(BuildContext context) {
    return MyIcon(_name, _isDarkMode);
  }
}

class MainScreenActiveTab extends StatelessWidget {
  final int tabIndex;
  String assetName;
  final String text;
  MainScreenActiveTab(this.tabIndex, this.assetName, this.text, {super.key}) {
    assetName = "assets/icons/$assetName.png";
  }
  @override
  Widget build(BuildContext context) {
    // print("2-2");

    final myColors = Theme.of(context).extension<MyColors>()!;
    return SlideTransitionExample(DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(50)),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ),
    ));
  }
}

class MyIcon extends StatelessWidget {
  final String _name;
  final bool _isDarkMode;
  const MyIcon(this._name, this._isDarkMode, {super.key});

  @override
  Widget build(BuildContext context) {
    return _isDarkMode
        ? Image(
            image: AssetImage(
              "assets/icons/$_name.png",
            ),
            height: _name == "home" ? 23 : 20)
        : Image(
            image: AssetImage(
              "assets/icons/${_name}_black.png",
            ),
            height: _name == "home" ? 23 : 20);
  }
}

class StaticAsset extends StatelessWidget {
  final String assetName;
  final double width;
  const StaticAsset(this.assetName, this.width, {super.key});
  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return Image(
        image: AssetImage("assets/icons/${assetName}_darkmode.png"),
        width: width,
        // height: width,
      );
    }
    return Image(
      image: AssetImage("assets/icons/$assetName.png"),
      width: width,
      // height: width,
    );
  }
}

class SlideTransitionExample extends StatefulWidget {
  const SlideTransitionExample(this._child, {super.key});
  final Widget _child;

  @override
  State<SlideTransitionExample> createState() => _SlideTransitionExampleState();
}

class _SlideTransitionExampleState extends State<SlideTransitionExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("3");
    InheritedWrapperMainScreenState state =
        InheritedWrapperMainScreen.of(context);
    final Animation<Offset> offsetAnimation = Tween<Offset>(
      begin: Offset(state.animOffsetX, 0),
      end: const Offset(0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));
    return SlideTransition(
      position: offsetAnimation,
      textDirection: TextDirection.rtl,
      child: widget._child,
    );
  }
}

class VerticalLine extends StatelessWidget {
  final Color color;
  final double thickness;
  final double length;
  const VerticalLine(
      {super.key,
      required this.color,
      required this.length,
      required this.thickness});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: SizedBox(
        height: length,
        width: thickness,
      ),
    );
  }
}

class HorizontalLine extends StatelessWidget {
  final Color color;
  final double length;
  final double thickness;
  const HorizontalLine(
      {super.key,
      required this.color,
      required this.thickness,
      required this.length});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: SizedBox(
        height: thickness,
        width: length,
      ),
    );
  }
}
