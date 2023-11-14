import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:stockd/presentation/screens/mainScreen/mainScreen_assets.dart';
// import 'package:stockd/presentation/screens/search/searchScreen_assets.dart';
import 'package:stockd/presentation/theming/themeExtensions.dart';
part 'searchScreen_assets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    return Scaffold(
        backgroundColor: myColors.primary2,
        appBar: AppBar(
          toolbarHeight: 50,
          leading: const _BackBtn(),
          backgroundColor: myColors.primary2,
          title: const _SearchScreenSearchBar(),
          actions: [
            clearBtn(myColors.secondary2),
          ],
        ),
        body: SafeArea(
            child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ColoredBox(
                color: myColors.primary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Previously Searched",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 17),
                        ),
                      ),
                      prevSearched(),
                    ],
                  ),
                ),
              ),
            )
          ],
        )));
  }
}
