import 'package:cube_transition_plus/cube_transition_plus.dart';
import 'package:flutter/material.dart';

class AllPage extends StatefulWidget {
  const AllPage({super.key});

  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final FixedExtentScrollController fixedExtentScrollController =
        FixedExtentScrollController();
    return Scaffold(
        body: Center(
      child: SizedBox(
        height: 400,
        // width: deviceWidth,
        child: CubePageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (context, index, notifier) {
              return CubeWidget(
                  index: index,
                  pageNotifier: notifier,
                  child: const ColoredBox(
                    color: Colors.red,
                    child: SizedBox(
                      width: 400,
                      height: 200,
                    ),
                  ));
            }),
      ),
    ));
  }
}
