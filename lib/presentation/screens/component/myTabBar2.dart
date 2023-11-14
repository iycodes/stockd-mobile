import 'package:flutter/material.dart';
import 'package:stockd/presentation/screens/mainScreen/home/home_assets.dart';
import 'package:stockd/presentation/theming/themeExtensions.dart';

class HomeTabBar3 extends StatefulWidget {
  const HomeTabBar3(this._tabNames, {super.key});
  final List<String> _tabNames;

  @override
  State<HomeTabBar3> createState() => _HomeTabBar3State();
}

class _HomeTabBar3State extends State<HomeTabBar3>
    with TickerProviderStateMixin {
  @override
  late final TabController _tabController;
  late int _currentIndex;
  final int _initialIndex = 0;
  late final _l = widget._tabNames;

  @override
  void initState() {
    _tabController = TabController(
        length: _l.length,
        vsync: this,
        animationDuration: const Duration(
          milliseconds: 300,
        ));
    super.initState();
    _currentIndex = _initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    return SizedBox(
      child: Column(
        children: [
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 15),
            labelColor: myColors.primary,
            // unselectedLabelColor: myColors.secondary,
            indicatorColor: Colors.black,
            indicator: BoxDecoration(
                color: myColors.secondary2,
                borderRadius: BorderRadius.circular(10)),
            onTap: setCurrIndex,
            overlayColor:
                const MaterialStatePropertyAll<Color>(Colors.transparent),
            isScrollable: true,
            controller: _tabController,
            // tabs: _l.asMap().entries.map((e) {
            //   return HomeTabBarBtn3(
            //     e.value,
            //     e.key,
            //     _currentIndex,
            //   );
            // }).toList()
            tabs: _l.asMap().entries.map((e) {
              return SizedBox(
                width: 120,
                child: Tab(
                  child: HomeTabBarBtn3(e.value, e.key, _currentIndex),
                ),
              );
            }).toList(),
          ),
          SizedBox(
            child: SizedBox(
              height: 700,
              child: TabBarView(controller: _tabController, children: const [
                // HomeTabItems(_l),
                // HomeTabItems(_l),
                // HomeTabItems(_l),
                // HomeTabItems(_l),
                // HomeTabItems(_l),
                // HomeTabItems(_l),
                // HomeTabItems(_l),
                // HomeTabItems(_l),
              ]),
            ),
          )
        ],
      ),
    );
  }

  setCurrIndex(index) {
    print(index);
    setState(() {
      _currentIndex = index;
    });
  }

  // scrollTo(index) {
  //   // print("idiot");
  //   setState(() {
  //     _currentIndex = index;
  //   });
  //   _tabController.animateTo(index);
  // }
}

class HomeTabBarBtn3 extends StatelessWidget {
  const HomeTabBarBtn3(this._iconName, this._index, this._currentIndex,
      {super.key});
  final String _iconName;
  final int _index;
  final int _currentIndex;
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    return ColoredBox(
      color: Colors.white54,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            HomeTabIcon(_iconName, _index, _currentIndex),
            Text(
              _iconName,
              style: const TextStyle(fontSize: 17),
            )
          ],
        ),
      ),
    );
  }
}

class HomeTabBarBtn2 extends StatelessWidget {
  const HomeTabBarBtn2(this._iconName, this._index, this._currentIndex,
      {super.key});
  final String _iconName;
  final int _index;
  final int _currentIndex;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: activeColor(), boxShadow: [
        BoxShadow(
          color: Colors.grey[600]!,
          spreadRadius: 3,
          blurRadius: 5,
        )
      ]),
      child: Row(
        children: [
          HomeTabIcon(_iconName, _index, _currentIndex),
          Text(_iconName)
        ],
      ),
    );
  }

  active(a, b) {
    _index == _currentIndex ? a : b;
  }

  Color activeColor() {
    if (_index == _currentIndex) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }
}

class HomeTabBarBtn1 extends StatelessWidget {
  const HomeTabBarBtn1(this._iconName, this._index, this._currentIndex,
      this._tabController, this.scrollTo,
      {super.key});
  final String _iconName;
  final int _index;
  final int _currentIndex;
  final TabController _tabController;
  final Function scrollTo;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        scrollTo();
      },
      style: TextButton.styleFrom(
          backgroundColor:
              _tabController.index == _index ? Colors.white : Colors.pink),
      child: Row(
        children: [
          HomeTabIcon(_iconName, _index, _currentIndex),
          Text(_iconName)
        ],
      ),
    );
  }

  oscrollTo(index) {
    _tabController.animateTo(index);
  }
}

homeTabBarBtnStyle(
  bool a,
  Color b,
) {
  if (a) {
    return BoxDecoration(color: b, borderRadius: BorderRadius.circular(10));
  }
  return BoxDecoration(
      color: b,
      // boxShadow: const [
      //   BoxShadow(
      //       color: Colors.black,
      //       spreadRadius: 2,
      //       blurRadius: 5,
      //       offset: Offset(2, 2),
      //       blurStyle: BlurStyle.inner)
      // ],
      borderRadius: BorderRadius.circular(10));
}
