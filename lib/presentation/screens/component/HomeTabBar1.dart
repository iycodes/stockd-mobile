import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockd/domain/api_repo.dart';
import 'package:stockd/presentation/screens/mainScreen/home/home_assets.dart';
import 'package:stockd/presentation/state/cubit/hometab1_cubit.dart';
import 'package:stockd/presentation/theming/themeExtensions.dart';

class HomeTabBar1 extends StatefulWidget {
  final List<String> _tabNames;
  final MyColors _myColors;
  // final List<Item> tabData;
  const HomeTabBar1(this._tabNames, this._myColors, {super.key});

  @override
  _HomeTabBar1State createState() => _HomeTabBar1State();
}

class _HomeTabBar1State extends State<HomeTabBar1>
    with TickerProviderStateMixin {
  // TickerProviderStateMixin allows the fade out/fade in animation when changing the active button
  final _apiRepo = ApiRepo();

  // this will control the button clicks and tab changing
  late TabController _controller;

  // this will control the animation when a button changes from an off state to an on state
  late AnimationController _animationControllerOn;

  // this will control the animation when a button changes from an on state to an off state
  late AnimationController _animationControllerOff;

  // this will give the background color values of a button when it changes to an on state
  late Animation _colorTweenBackgroundOn;
  late Animation _colorTweenBackgroundOff;

  // this will give the foreground color values of a button when it changes to an on state
  late Animation _colorTweenForegroundOn;
  late Animation _colorTweenForegroundOff;

  // when swiping, the _controller.index value only changes after the animation, therefore, we need this to trigger the animations and save the current index
  int _currentIndex = 0;

  // saves the previous active tab
  int _prevControllerIndex = 0;

  // saves the value of the tab animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
  double _aniValue = 0.0;

  // saves the previous value of the tab animation. It's used to figure the direction of the animation
  double _prevAniValue = 0.0;

  MyColors? myColors;

  // these will be our tab icons. You can use whatever you like for the content of your buttons
  final List _icons = [
    Icons.star,
    Icons.whatshot,
    Icons.call,
    Icons.contacts,
    Icons.email,
    Icons.donut_large,
    Icons.donut_large,
    Icons.donut_large,
  ];

  late final List tabNames = widget._tabNames;

  // active button's foreground color
  final Color _foregroundOn = Colors.white;
  late final Color _foregroundOff = widget._myColors.secondary2;

  // active button's background color
  late final Color _backgroundOn = widget._myColors.secondary;
  late final Color _backgroundOff = widget._myColors.primary2;

  // scroll controller for the TabBar
  final ScrollController _scrollController = ScrollController();

  late final List _keys =
      List.generate(tabNames.length, (index) => GlobalKey());

  // regist if the the button was tapped
  bool _buttonTap = false;
  // bool isColorLoading = true;

  @override
  void initState() {
    _controller = TabController(
        vsync: this,
        length: tabNames.length,
        initialIndex: _currentIndex,
        animationDuration: const Duration(milliseconds: 200));
    // this will execute the function every time there's a swipe animation
    _controller.animation!.addListener(_handleTabAnimation);
    // this will execute the function every time the _controller.index value changes
    _controller.addListener(_handleTabChange);
    _animationControllerOff = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 60));
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOff.value = 1.0;
    _colorTweenBackgroundOff =
        ColorTween(begin: _backgroundOn, end: _backgroundOff)
            .animate(_animationControllerOff);
    _colorTweenForegroundOff =
        ColorTween(begin: _foregroundOn, end: _foregroundOff)
            .animate(_animationControllerOff);

    _animationControllerOn = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    // so the inactive buttons start in their "final" state (color)
    _animationControllerOn.value = 1.0;
    _colorTweenBackgroundOn =
        ColorTween(begin: _backgroundOff, end: _backgroundOn)
            .animate(_animationControllerOn);
    _colorTweenForegroundOn =
        ColorTween(begin: _foregroundOff, end: _foregroundOn)
            .animate(_animationControllerOn);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final apiRepo = ApiRepo();

  Color mycc = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    final MyColors myColors = Theme.of(context).extension<MyColors>()!;
    final homeTab1Bloc = BlocProvider.of<Hometab1Cubit>(context);
    final homeTab1State = homeTab1Bloc.state;

    return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 500),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // this is the TabBar
            SizedBox(
                height: 55.0,
                // this generates our tabs buttons
                child: ListView(
                  cacheExtent: 500,
                  // addAutomaticKeepAlives: true,
                  // addRepaintBoundaries: false,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  // this gives the TabBar a bounce effect when scrolling farther than it's size
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  // number of tabs
                  children: tabNames.asMap().entries.map((e) {
                    final index = e.key;
                    return Padding(
                        // each button's key
                        key: _keys[index],
                        // padding for the buttons
                        padding: index == 0
                            ? const EdgeInsets.only(left: 10, right: 20)
                            : const EdgeInsets.only(
                                right: 20,
                              ),
                        child: AnimatedBuilder(
                          animation: _colorTweenBackgroundOn,
                          builder: (context, child) => DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                // boxShadow: boxShadow,
                                border: Border.all(
                                    color: myColors.secondary2, width: 0.5),
                                color: _getBackgroundColor(index)),
                            child: InkWell(
                              splashColor: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {
                                setState(() {
                                  _buttonTap = true;
                                  // trigger the controller to change between Tab Views
                                  _controller.animateTo(index);
                                  // set the current index
                                  _setCurrentIndex(index);
                                  // scroll to the tapped button (needed if we tap the active button and it's not on its position)
                                  _scrollTo(index);
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    HomeTabIcon(
                                        tabNames[index], index, _currentIndex),
                                    Text(
                                      tabNames[index],
                                      // textAlign: TextAlign.center,
                                      // textHeightBehavior:,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: _getForegroundColor(index)
                                          // backgroundColor: Colors.green,
                                          ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ));
                  }).toList(),
                )),
            // Flexible(
            //     // this will host our Tab Views
            //     child:

            Flexible(
                child: TabBarView(
              // and it is controlled by the controller
              controller: _controller,

              // viewportFraction: 0.9,

              children: <Widget>[
                // our Tab Views
                HomeTabItems(homeTab1State.data!.items),
                Icon(_icons[1]),
                Icon(_icons[2]),
                Icon(_icons[3]),
                Icon(_icons[4]),
                Icon(_icons[5]),
                Icon(_icons[5]),
                Icon(_icons[5]),
              ],
            ))
            // ),
          ],
        ));
  }

  // runs during the switching tabs animation
  _handleTabAnimation() {
    // gets the ApiResponse ue ohe async animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
    _aniValue = _controller.animation!.value;

    // if the button wasn't pressed, which means the user is swiping, and the amount swipped is less than 1 (this means that we're swiping through neighbor Tab Views)
    if (!_buttonTap && ((_aniValue - _prevAniValue).abs() < 1)) {
      // set the current tab index
      _setCurrentIndex(_aniValue.round());
    }

    // save the previous Animation Value
    _prevAniValue = _aniValue;
  }

  // runs when the displayed tab changes
  _handleTabChange() {
    // if a button was tapped, change the current index
    if (_buttonTap) _setCurrentIndex(_controller.index);

    // this resets the button tap
    if ((_controller.index == _prevControllerIndex) ||
        (_controller.index == _aniValue.round())) _buttonTap = false;

    // save the previous controller index
    _prevControllerIndex = _controller.index;
  }

  _setCurrentIndex(int index) {
    // if we're actually changing the index
    if (index != _currentIndex) {
      setState(() {
        // change the index
        _currentIndex = index;
      });

      // trigger the button animation
      _triggerAnimation();
      // scroll the TabBar to the correct position (if we have a scrollable bar)
      _scrollTo(index);
    }
  }

  _triggerAnimation() {
    // reset the animations so they're ready to go
    _animationControllerOn.reset();
    _animationControllerOff.reset();

    // run the animations!
    _animationControllerOn.forward();
    _animationControllerOff.forward();
  }

  _scrollTo(int index) {
    // get the screen width. This is used to check if we have an element off screen
    double screenWidth = MediaQuery.of(context).size.width;

    // get the button we want to scroll to
    RenderBox renderBox = _keys[index].currentContext.findRenderObject();
    // get its size
    double size = renderBox.size.width;
    // and position
    double position = renderBox.localToGlobal(Offset.zero).dx;

    // this is how much the button is away from the center of the screen and how much we must scroll to get it into place
    double offset = (position + size / 2) - screenWidth / 2;

    // if the button is to the left of the middle
    if (offset < 0) {
      // get the first button
      renderBox = _keys[0].currentContext.findRenderObject();
      // get the position of the first button of the TabBar
      position = renderBox.localToGlobal(Offset.zero).dx;

      // if the offset pulls the first button away from the left side, we limit that movement so the first button is stuck to the left side
      if (position > offset) offset = position;
    } else {
      // if the button is to the right of the middle

      // get the last button
      renderBox = _keys[tabNames.length - 1].currentContext.findRenderObject();
      // get its position
      position = renderBox.localToGlobal(Offset.zero).dx;
      // and size
      size = renderBox.size.width;

      // if the last button doesn't reach the right side, use it's right side as the limit of the screen for the TabBar
      if (position + size < screenWidth) screenWidth = position + size;

      // if the offset pulls the last button away from the right side limit, we reduce that movement so the last button is stuck to the right side limit
      if (position + size - offset < screenWidth) {
        offset = position + size - screenWidth;
      }
    }

    // scroll the calculated ammount
    _scrollController.animateTo(offset + _scrollController.offset,
        duration: const Duration(milliseconds: 150), curve: Curves.easeInOut);
  }

  _getBackgroundColor(int index) {
    if (index == _currentIndex) {
      // if it's active button
      return _colorTweenBackgroundOn.value;
    } else if (index == _prevControllerIndex) {
      // if it's the previous active button
      return _colorTweenBackgroundOff.value;
    } else {
      // if the button is inactive
      return _backgroundOff;
    }
  }

  _getForegroundColor(int index) {
    // the same as the above
    if (index == _currentIndex) {
      return _colorTweenForegroundOn.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenForegroundOff.value;
    } else {
      return _foregroundOff;
    }
  }

  static const boxShadow = [
    BoxShadow(
      color: Colors.black54,
      // color: Colors.brown,
      // spreadRadius: 2,
      blurRadius: 5,
      blurStyle: BlurStyle.normal,
    )
  ];
}
