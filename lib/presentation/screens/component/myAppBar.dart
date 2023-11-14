import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stockd/presentation/screens/mainScreen/home/home_assets.dart';
import 'package:stockd/presentation/screens/mainScreen/mainScreen_assets.dart';
import 'package:stockd/presentation/theming/themeExtensions.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageName;
  const MyAppBar(this.pageName, {super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    return AppBar(
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 50,
      centerTitle: true,
      backgroundColor: myColors.secondary2,
      leading: IconButton(
        onPressed: () {
          context.beamBack();
        },
        icon: const StaticAsset("backArrow", 22),
        splashColor: Colors.redAccent,
        focusColor: Colors.redAccent,
        color: Colors.redAccent,
      ),
      title: Text(
        pageName,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 17, color: HexColor("#ffffff")),
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.beamToNamed("searchScreen");
            // Beamer.of(context).beamToNamed("/searchScreen");
          },
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              foregroundColor: Colors.grey,
              padding: const EdgeInsets.all(0)),
          child: const StaticAsset("searchBox", 40),
        ),
        const _MyAppBarMenu()
      ],
    );
  }
}

class _MyAppBarMenu extends StatelessWidget {
  const _MyAppBarMenu();

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    return PopupMenuButton(
        color: myColors.primary2.withOpacity(0.95),
        icon: const StaticAsset("more1", 25),
        surfaceTintColor: Colors.transparent,
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: '1',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    StaticAsset("home", 20),
                    Xspacer(10),
                    Text(
                      'Home',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              const PopupMenuItem(
                value: '2',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    StaticAsset("all", 20),
                    Xspacer(10),
                    Text(
                      'Categories',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              const PopupMenuItem(
                value: '3',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    StaticAsset("user", 20),
                    Xspacer(10),
                    Text(
                      'Account',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ]);
  }
}
