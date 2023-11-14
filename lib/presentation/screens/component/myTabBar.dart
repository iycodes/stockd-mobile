// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:stockd/presentation/screens/component/ItemCard.dart';
// import 'package:stockd/presentation/screens/component/shimmer.dart';
// import 'package:stockd/presentation/theming/themeExtensions.dart';

// class MyTabBar extends StatefulWidget {
//   final List<String> _tabNames;
//   final MyColors _myColors;
//   const MyTabBar(this._tabNames, this._myColors, {super.key});

//   @override
//   State<MyTabBar> createState() => _MyTabBarState();
// }

// class _MyTabBarState extends State<MyTabBar> with TickerProviderStateMixin {
//   late TabController _tabController;
//   int _currentIndex = 0;
//   int _prevIndex = 0;
//   late AnimationController _animationControllerOn;
//   late AnimationController _animationControllerOff;
//   late Animation _colorTweenBackgroundOn;
//   late Animation _colorTweenBackgroundOff;
//   late Animation _colorTweenForegroundOn;
//   late Animation _colorTweenForegroundOff;
//   double _animValue = 0.0; // saved the value of the current tab animation
//   double _prevAnimValue = 0.0; // saves the value of the prev tab animation
//   // List _Icons
//   late final Color _foregroundOn = widget._myColors.primary2;
//   late final Color _foregroundOff = widget._myColors.secondary2;
//   late final Color _backgroundOn = widget._myColors.secondary2;
//   final Color _backgroundOff = Colors.transparent;
//   //
//   final ScrollController _scrollController = ScrollController();

//   final List _tabKeys =
//       []; // save all the keys for each tab which we will generate in initstate

//   // regist if the the button was tapped
//   bool _buttonTapped = false;
//   @override
//   void initState() {
//     for (var i = 0; i < widget._tabNames.length; i++) {
//       // final GlobalKey globalKey = new GlobalKey();
//       _tabKeys.add(GlobalKey());
//       // print(_tabKeys);
//     }
//     _tabController =
//         TabController(length: widget._tabNames.length, vsync: this);
//     _tabController.animation!.addListener(_handleTabAnimation);
//     _tabController.addListener(_handleTabChange);
//     _animationControllerOff =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 75));
//     // so the inactive buttons start in their "final" state (color)
//     _animationControllerOff.value = 1.0;
//     _colorTweenBackgroundOff =
//         ColorTween(begin: _backgroundOn, end: _backgroundOff)
//             .animate(_animationControllerOff);
//     _colorTweenForegroundOff =
//         ColorTween(begin: _foregroundOn, end: _foregroundOff)
//             .animate(_animationControllerOff);

//     _animationControllerOn =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 150));
//     // so the inactive buttons start in their "final" state (color)
//     _animationControllerOn.value = 1.0;
//     _colorTweenBackgroundOn =
//         ColorTween(begin: _backgroundOff, end: _backgroundOn)
//             .animate(_animationControllerOn);
//     _colorTweenForegroundOn =
//         ColorTween(begin: _foregroundOff, end: _foregroundOn)
//             .animate(_animationControllerOn);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(bottom: 15),
//           child: SizedBox(
//               height: 49.0,
//               // this generates our tabs buttons
//               child: ListView.builder(
//                   cacheExtent: 500,
//                   // this gives the TabBar a bounce effect when scrolling farther than it's size
//                   physics: BouncingScrollPhysics(),
//                   controller: _scrollController,
//                   // make the list horizontal
//                   scrollDirection: Axis.horizontal,
//                   // number of tabs
//                   itemCount: widget._tabNames.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Padding(
//                         // each button's key
//                         key: _tabKeys[index],
//                         // padding for the buttons
//                         padding: const EdgeInsets.only(
//                           right: 20,
//                         ),
//                         child: ButtonTheme(
//                             child: AnimatedBuilder(
//                           animation: _colorTweenBackgroundOn,
//                           builder: (context, child) => TextButton(
//                               // get the color of the button's background (dependent of its state)
//                               // color: _getBackgroundColor(index),
//                               style: TextButton.styleFrom(
//                                   backgroundColor: _getBackgroundColor(index),
//                                   shape: RoundedRectangleBorder(
//                                       side: BorderSide(
//                                           // width: 1,
//                                           // color: index == _currentIndex
//                                           //     ? Colors.transparent
//                                           //     : widget._myColors.lightGrey

//                                           ),
//                                       borderRadius:
//                                           BorderRadius.circular(7.0))),
//                               onPressed: () {
//                                 setState(() {
//                                   _buttonTapped = true;
//                                   // trigger the controller to change between Tab Views
//                                   _tabController.animateTo(index);
//                                   // set the current index
//                                   _setCurrentIndex(index);
//                                   // scroll to the tapped button (needed if we tap the active button and it's not on its position)
//                                   _scrollTo(index);
//                                 });
//                               },
//                               child: Opacity(
//                                 opacity: index == _currentIndex ? 1 : 0.7,
//                                 child: Row(
//                                   // mainAxisAlignment:
//                                   //     MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     // _tabKeys[index],
//                                     // HomeTabIcon(widget._tabNames[index], index,
//                                     //     _currentIndex),
//                                     MyIcon(widget._tabNames[index]),
//                                     Text(
//                                       widget._tabNames[index],
//                                       style: TextStyle(
//                                           color: _getForegroundColor(index),
//                                           fontWeight: FontWeight.w800,
//                                           fontSize: 20),
//                                     ),
//                                   ],
//                                 ),
//                               )),
//                         )));
//                   })),
//         ),
//         Flexible(
//             // this will host our Tab Views
//             child: TabBarView(
//           // and it is controlled by the controller
//           controller: _tabController,
//           children: <Widget>[
//             ListView(
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ItemCard(
//                         "itemId",
//                         "https://i.pinimg.com/originals/48/82/90/48829048fdc28f4b15176205be7b1b77.jpg",
//                         "SEXY GOWN",
//                         4999,
//                         "9%"),
//                     MyShimmerItem()
//                   ],
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ItemCard(
//                         "itemId",
//                         "https://i.pinimg.com/originals/48/82/90/48829048fdc28f4b15176205be7b1b77.jpg",
//                         "SEXY GOWN",
//                         4999,
//                         "9%"),
//                     MyShimmerItem()
//                   ],
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [MyShimmerItem()],
//                 ),
//               ],
//             ),
//             ListView(
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(top: 20),
//                   child: ItemCard(
//                       "itemId",
//                       "https://i.pinimg.com/originals/1f/b0/df/1fb0df85bff142743509656f9197a985.jpg",
//                       "Nice Shirt",
//                       4999,
//                       "9%"),
//                 ),
//               ],
//             ),
//             Text("data"),
//             Text("data"),
//             Text("data"),
//             Text("data"),
//             Text("data"),
//             Text("data"),
//             // our Tab Views
//             // _tabKeys[0].tabIcon,
//             // _tabKeys[1].tabIcon,
//             // _tabKeys[2].tabIcon,
//             // _tabKeys[3].tabIcon,
//             // _tabKeys[4].tabIcon,
//             // _tabKeys[5].tabIcon
//           ],
//         ))
//       ],
//     );
//   }

//   _handleTabAnimation() {
//     // gets the value of the animation. For example, if one is between the 1st and the 2nd tab, this value will be 0.5
//     _animValue = _tabController.animation!.value;

//     // if the button wasn't pressed, which means the user is swiping, and the amount swipped is less than 1 (this means that we're swiping through neighbor Tab Views)
//     if (!_buttonTapped && ((_animValue - _prevAnimValue).abs() < 1)) {
//       // set the current tab index
//       _setCurrentIndex(_animValue.round());
//     }

//     // save the previous Animation Value
//     _prevAnimValue = _animValue;
//   }

//   // runs when the displayed tab changes
//   _handleTabChange() {
//     // if a button was tapped, change the current index
//     if (_buttonTapped) _setCurrentIndex(_tabController.index);

//     // this resets the button tap
//     if ((_tabController.index == _prevIndex) ||
//         (_tabController.index == _animValue.round())) _buttonTapped = false;

//     // save the previous controller index
//     _prevIndex = _tabController.index;
//   }

//   _setCurrentIndex(int index) {
//     // if we're actually changing the index
//     if (index != _currentIndex) {
//       setState(() {
//         // change the index
//         _currentIndex = index;
//       });

//       // trigger the button animation
//       _triggerAnimation();
//       // scroll the TabBar to the correct position (if we have a scrollable bar)
//       _scrollTo(index);
//     }
//   }

//   _triggerAnimation() {
//     // reset the animations so they're ready to go
//     _animationControllerOn.reset();
//     _animationControllerOff.reset();

//     // run the animations!
//     _animationControllerOn.forward();
//     _animationControllerOff.forward();
//   }

//   _scrollTo(int index) {
//     // get the screen width. This is used to check if we have an element off screen
//     double screenWidth = MediaQuery.of(context).size.width;

//     // get the button we want to scroll to
//     RenderBox renderBox = _tabKeys[index].currentContext.findRenderObject();
//     // get its size
//     double size = renderBox.size.width;
//     // and position
//     double position = renderBox.localToGlobal(Offset(0, 0)).dx;

//     // this is how much the button is away from the center of the screen and how much we must scroll to get it into place
//     double offset = (position + size / 2) - screenWidth / 2;

//     // if the button is to the left of the middle
//     if (offset < 0) {
//       // get the first button
//       // print("leff");
//       renderBox = _tabKeys[1].currentContext.findRenderObject();
//       // get the position of the first button of the TabBar
//       position = renderBox.localToGlobal(Offset(-30, 0)).dx;

//       // if the offset pulls the first button away from the left side, we limit that movement so the first button is stuck to the left side
//       if (position > offset) offset = position;
//     } else {
//       // if the button is to the right of the middle

//       // get the last button
//       renderBox = _tabKeys[widget._tabNames.length - 1]
//           .currentContext
//           .findRenderObject();
//       // get its position
//       position = renderBox.localToGlobal(Offset(0, 0)).dx;
//       // and size
//       size = renderBox.size.width;

//       // if the last button doesn't reach the right side, use it's right side as the limit of the screen for the TabBar
//       if (position + size < screenWidth) screenWidth = position + size;

//       // if the offset pulls the last button away from the right side limit, we reduce that movement so the last button is stuck to the right side limit
//       if (position + size - offset < screenWidth) {
//         offset = position + size - screenWidth;
//       }
//     }

//     // scroll the calculated ammount
//     _scrollController.animateTo(offset + _scrollController.offset + 10.0,
//         duration: new Duration(milliseconds: 150), curve: Curves.easeInOut);
//   }

//   _getBackgroundColor(int index) {
//     if (index == _currentIndex) {
//       // if it's active button
//       return _colorTweenBackgroundOn.value;
//     } else if (index == _prevIndex) {
//       // if it's the previous active button
//       return _colorTweenBackgroundOff.value;
//     } else {
//       // if the button is inactive
//       return _backgroundOff;
//     }
//   }

//   _getForegroundColor(int index) {
//     // the same as the above
//     if (index == _currentIndex) {
//       return _colorTweenForegroundOn.value;
//     } else if (index == _prevIndex) {
//       return _colorTweenForegroundOff.value;
//     } else {
//       return _foregroundOff;
//     }
//   }
// }

// class MyIcon extends StatelessWidget {
//   final String _iconName;
//   const MyIcon(this._iconName, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ColoredBox(
//       color: Colors.white,
//       child: Image(image: AssetImage("assets/icons/$_iconName.png")),
//     );
//   }
// }

// class TabMap {
//   final dynamic tabKey;
//   final String _iconName;
//   late Widget tabIcon = Padding(
//     padding: const EdgeInsets.only(right: 5),
//     child: MyIcon(_iconName),
//   );
//   TabMap(
//     this.tabKey,
//     this._iconName,
//   );
// }

// class HomeTabIcon extends StatelessWidget {
//   const HomeTabIcon(this._iconName, this._index, this._currentIndex,
//       {super.key});
//   final String _iconName;
//   final int _index;
//   final int _currentIndex;
//   @override
//   Widget build(BuildContext context) {
//     final String path1 = "assets/icons/$_iconName.png";
//     final String path2 = "assets/icons/${_iconName}_active.png";

//     return Image(
//       image: AssetImage(_index == _currentIndex ? path2 : path1),
//       width: 20,
//     );
//   }
// }
