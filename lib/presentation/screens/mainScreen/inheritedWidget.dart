import 'package:flutter/cupertino.dart';

class InheritedWidgetMainScreen extends InheritedWidget {
  const InheritedWidgetMainScreen(
      {super.key, required this.child, required this.data})
      : super(child: child);

  @override
  final Widget child;
  final InheritedWrapperMainScreenState data;

  @override
  bool updateShouldNotify(InheritedWidgetMainScreen oldWidget) {
    return data != oldWidget.data;
  }
}

class InheritedWrapperMainScreen extends StatefulWidget {
  final Widget child;
  // final PageController pageController;
  const InheritedWrapperMainScreen({
    super.key,
    required this.child,
    // required this.pageController,
  });

  static InheritedWrapperMainScreenState of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<InheritedWidgetMainScreen>())!
        .data;
  }

  @override
  State<InheritedWrapperMainScreen> createState() =>
      InheritedWrapperMainScreenState();
}

class InheritedWrapperMainScreenState
    extends State<InheritedWrapperMainScreen> {
  double animOffsetX = 0.0;
  @override
  void initState() {
    // pageController = widget.pageController;
    super.initState();
  }

  void setAnimOffset(x) {
    setState(() {
      animOffsetX = x;
      // print(x);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedWidgetMainScreen(
      data: this,
      child: widget.child,
    );
  }
}
