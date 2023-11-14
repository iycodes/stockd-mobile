import 'package:flutter/material.dart';
import 'package:stockd/presentation/screens/mainScreen/home/home.dart';
import 'package:stockd/presentation/screens/mainScreen/mainScreen.dart';
import 'package:stockd/presentation/screens/mainScreen/mainScreen_assets.dart';
import 'package:stockd/presentation/theming/themeExtensions.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  void _selectScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const _tabs = ["all", "cart", "home", "saved", "user"];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final myColors = Theme.of(context).extension<MyColors>()!;
    return Scaffold(
      backgroundColor: myColors.primary2,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: NavigationBar(
            backgroundColor: myColors.primary2,
            surfaceTintColor: myColors.primary2,
            indicatorColor: Colors.transparent,
            height: 50,
            onDestinationSelected: _selectScreen,
            selectedIndex: _selectedIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            destinations: _tabs
                .asMap()
                .entries
                .map((e) => NavigationDestination(
                    icon: MainScreenTab(isDarkMode, e.value),
                    label: e.value,
                    selectedIcon: MainScreenActiveTab(
                        e.key, "${e.value}_active", capitalize(e.value))))
                .toList()),
      ),
      body: [
        Container(
          child: const Home(),
        ),
        Text(
          _selectedIndex.toString(),
        ),
        Text(
          _selectedIndex.toString(),
        ),
        Text(
          _selectedIndex.toString(),
        ),
        Text(_selectedIndex.toString()),
      ][_selectedIndex],
    );
  }
}
