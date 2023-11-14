import 'package:flutter/material.dart';
import 'package:stockd/presentation/screens/mainScreen/all/all.dart';
import 'package:stockd/presentation/screens/mainScreen/cart/cartScreen.dart';
import 'package:stockd/presentation/screens/mainScreen/home/home.dart';
import 'package:stockd/presentation/screens/mainScreen/inheritedWidget.dart';
import 'package:stockd/presentation/screens/mainScreen/mainScreen_assets.dart';
import 'package:stockd/presentation/screens/mainScreen/user/user.dart';
import 'package:stockd/presentation/theming/themeExtensions.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late final PageController _pageController;
  final List<Widget> _pages = const [Home(), AllPage(), CartPage(), UserPage()];

  @override
  void initState() {
    _pageController = PageController(
      initialPage: _selectedIndex,
    );
    super.initState();
  }

  static const _tabs = ["home", "menu", "feed", "user"];

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final myColors = Theme.of(context).extension<MyColors>()!;
    final deviceWidth = MediaQuery.of(context).size.width;
    bool isAuth = false;
    final InheritedWrapperMainScreenState state =
        InheritedWrapperMainScreen.of(context);

    void selectScreen(int index) {
      if (_selectedIndex > index) {
        state.setAnimOffset(-0.15);
      } else {
        state.setAnimOffset(0.15);
      }
      setState(() {
        // print("$_selectedIndex,$index");
        _pageController.jumpToPage(index);
        _selectedIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: myColors.primary2,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: SafeArea(
          child: SizedBox(
        height: 35,
        child: Column(
          children: [
            HorizontalLine(
              color: Colors.white,
              thickness: 1,
              length: deviceWidth,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: NavigationBar(
                  backgroundColor: myColors.primary2,
                  surfaceTintColor: myColors.primary2,
                  indicatorColor: Colors.transparent,
                  height: 30,
                  shadowColor: Colors.transparent,
                  onDestinationSelected: selectScreen,
                  selectedIndex: _selectedIndex,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                  destinations: _tabs
                      .asMap()
                      .entries
                      .map(
                        (e) => NavigationDestination(
                            icon: MainScreenTab(isDarkMode, e.value),
                            label: e.value,
                            selectedIcon: SizedBox(
                              width: 70,
                              child: MainScreenActiveTab(e.key,
                                  "${e.value}_active", capitalize(e.value)),
                            )),
                      )
                      .toList(),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

String capitalize(String e) => e[0].toUpperCase() + (e.substring(1));
