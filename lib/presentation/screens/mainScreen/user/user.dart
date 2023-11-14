import 'package:flutter/material.dart';
import 'package:stockd/presentation/screens/mainScreen/user/user_assets.dart';
import 'package:stockd/presentation/theming/themeExtensions.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    return const Scaffold(
      // backgroundColor: myColors.secondary,
      body: SafeArea(
          child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "User",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            UserPageSection("Inbox"),
            UserPageSection("Orders"),
            UserPageSection("Customer Service"),
            UserPageSection("Recently Viewed"),
            UserPageSection("Followed Sellers"),
            UserPageSection("Follow us"),
            UserPageSection("App Settings"),
          ],
        ),
      )),
    );
  }
}
