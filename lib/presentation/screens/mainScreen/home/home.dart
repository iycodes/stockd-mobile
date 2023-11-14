import 'package:beamer/beamer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cube_transition_plus/cube_transition_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockd/presentation/screens/component/myShimmerPage.dart';
import 'package:stockd/presentation/screens/mainScreen/home/home_assets.dart';
import 'package:stockd/presentation/screens/mainScreen/home/home_section1.dart';
import 'package:stockd/presentation/screens/mainScreen/mainScreen_assets.dart';
import 'package:stockd/presentation/state/user/cubit/user_cubit.dart';
import 'package:stockd/presentation/theming/themeExtensions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with AutomaticKeepAliveClientMixin<Home>, SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    BlocListener<UserCubit, UserState>(listener: (context, state) {
      print(state.loggedInUser);
    });
    final deviceHeight = MediaQuery.of(context).size.height;
    final MyColors myColors = Theme.of(context).extension<MyColors>()!;
    final devicewidth = MediaQuery.of(context).size.width;
    // final pad = devicewidth * 0.05;
    const pad = 20.0;
    final List<String> tabNames = [
      "Top",
      "New",
      "Men",
      "Women",
      "Gadgets",
      "Beauty",
      "Homee",
      'Gaming'
    ];
    return Scaffold(
      backgroundColor: myColors.primary2,
      // appBar: AppBar(
      //   // elevation: 2,
      //   backgroundColor: myColors.primary2,
      //   surfaceTintColor: myColors.primary2,
      //   titleSpacing: 0,
      //   // foregroundColor: myColors.primary2,1
      //   centerTitle: false,
      //   title: const MySearchBar(pad),
      //   toolbarHeight: 50,
      // ),
      body: SizedBox(
        height: deviceHeight,
        width: devicewidth,
        child: Stack(
          children: [
            CubePageView(
              scrollDirection: Axis.vertical,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      cacheKey: bkgImages[0],
                      bkgImages[0],
                    ),
                  )),
                  child: SizedBox(
                    height: deviceHeight,
                    width: devicewidth,
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  context.beamToNamed("searchScreen");
                                },
                                splashColor: Colors.red,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.8, color: Colors.white)),
                                  child: SizedBox(
                                    width: devicewidth * 0.8,
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Text(
                                        "SEARCH",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context.beamToNamed("/cart");
                                },
                                icon: const StaticAsset("cart1", 30),
                              )
                            ],
                          ),
                          const Yspacer(40)
                        ]),
                  ),
                ),
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: deviceHeight,
                  imageUrl:
                      "https://images.unsplash.com/photo-1598971861713-54ad16a7e72e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2488&q=80",
                ),
                Image(
                  fit: BoxFit.cover,
                  height: deviceHeight,
                  image: const AssetImage("assets/icons/shoppingimage.jpg"),
                ),
                const HomePageSection1(),
                MyShimmerPage()
              ],
            ),
            Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: Align(
                  // alignment: Alignment.center,
                  // child: Text(
                  //   "STOCKD",
                  //   style: TextStyle(
                  //       fontSize: 70,
                  //       // letterSpacing: ,
                  //       wordSpacing: 0,
                  //       fontFamily: "Cinzel",
                  //       fontWeight: FontWeight.w900),
                  // ),
                  child: Opacity(
                    opacity: 0.5,
                    child: StaticAsset("stockd", devicewidth * 0.4),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

// Furthermore, you should not use context.read<T>() in the BlocBuilder as you do, it is not recommended.
//  If you want to act on the state change, use a BlocListener instead.

final bkgImages = [
  "https://images.unsplash.com/photo-1598971861713-54ad16a7e72e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2488&q=80",
];
